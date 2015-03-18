class Scraping
#音友コンサートガイドhttp://www.ongakunotomo.co.jp/concert/の検索欄に新日本フィルハーモニー交響楽団というキーワードを入れる。
#スクレイピングするとき、オーケストラとかこんさーとテーブルに入っていない情報だったら、テーブルに追加して、テーブルの一番最後（つまり今とってきたやつ）のidを返り値として返す。もし入っていたら、そのidを返す。    first_or_initializeはorchestra,title,day,timeで当てる。
#最後に、コンサートをまとめて保存。
  require 'mechanize'

  def get_orchestras
    orchestras = %W(東京都交響楽団 東京フィルハーモニー交響楽団 東京交響楽団 読売日本交響楽団 新日本フィルハーモニー交響楽団 日本フィルハーモニー交響楽団)
    orchestras.each do |orch|
      get_concerts(orch)
    end
  end

  def get_concerts(keywords)

    @orchestraname = keywords
    links = []
    agent = Mechanize.new
    page = agent.get('http://search.ebravo.jp/')
    response = page.form_with(:name => 'search_form_hope') do |form|
      form.field_with(:id => "ConcertFree1").value = @orchestraname #オーケストラ名を検索
      form.checkbox_with(:text => "オーケストラ").check
    end.submit    #responseに検索結果のURLが入る。

    while true do
      infoboxes = response.search('.listSummary')
      infoboxes.each do |box|
        links << box.at('.box3 a').get_attribute('href') if (box.at('.box2').inner_text === '東京' || box.at('.box2').inner_text === '神奈川' ) && !box.at('.box1').inner_text.empty?
      end
      if response.at('.next').nil?
        break
      end
      next_link = response.at('.next a').get_attribute('href')
      next_page = ('http://search.ebravo.jp' + next_link)
      response = agent.get(next_page)
    end

    if @orchestraname == "日本フィルハーモニー交響楽団"
      links.each do |link|
        get_jpo_concert(link)
      end
    else
      links.each do |link|
        get_concert(link)
      end
    end

  end


  def get_concert(links)

    agent = Mechanize.new
    page = agent.get('http://search.ebravo.jp' + links)
    title = page.search('h2').inner_text
    day = page.search('.w290 p').inner_text
    #advance_sale_day = page.search('.w280 p').inner_text if page.search('.w280 p')
    time = page.search('tr[2] td[2] p').inner_text
    place_name = page.search('tr[3] td[2] p').inner_text
    # ここまでは全て共通
    concert_elements = page.search('tr[4] p')  #公演情報のpタグをとる。
    texts = []                                 #公演情報をそれぞれ文字列にして入れる配列
    concert_elements.each do |ele|             #その処理。
      texts << ele.inner_text
    end

    texts.each do |text|
      if text[0] == "料"
        price = text.split("／")[1]
      elsif text[0] == "問"
        contact_texts = text.split("／", 2)[1]#まず／で分割して"問／"を除く
        contact_text = contact_texts.split[0]     #複数は厄介だから最初のだけ
        contact_name = contact_text.split("0")[0]       #市街局番の０をキーにして電話番号と名前を分割。ここでは問い合わせ先をcontact_nameに。
        contact_number = "0" + contact_text.split("0", 2)[1]         #電話番号は分割に使った0を先頭につけたして。
      elsif text[0] == "※"
        another_content = text
      elsif text[0] == "曲"
        content = text.split("／", 2)[1]
        #ここまでは、<p>の中に／がひとつだけのもの。以下はそれ以外で
      else
        elements = text.split("　")      #<p>タグの中身を全角スペースのところで区切って配列に入れる。
        artist_ids = []         #コンサートテーブルに必要なartist_idを入れる配列
        elements.each do |ele|
          if ele[0] == "合"
            choruses = ele.split("／", 2)[1].split
            choruses.each do |chor|
              artist_name = chor
              artist = Artist.where(artist_name: artist_name).first_or_initialize
              artist.save
              artist_ids << artist.id
            end
            role = "合唱"      #これどうする？
          elsif ele[0] == "独"
            artists = ele.split("／", 2)[1].split      #独は複数いる場合があるので、／で割って、さらに空白で割る。
            artists.each do |art|
              if art[0] == "他"     #eleの中身が"出／古部賢一ob 他"みたいなときの処理。とりあえず後回し（共のとこも同じ）。
                #現状何もしない
              else
                artist_name = art.scan(/[^a-zA-ZＡ-Ｚ]/).join  #アルファベット以外の文字列を配列で取り、連結。
                short_name = art.scan(/[a-zA-ZＡ-Ｚ]/).join  #これは、obとかvlnとか。アルファベットの文字列を配列で取り、連結。
                #もう一回考える。まずInstrumentalテーブルに保存してから、idをとってくる。
                instrument = Instrument.where(short_name: short_name)first_or_initialize
                instrument.save
                inst_id = instrument.id
                artist = Artist.where(artist_name: artist_name).first_or_initialize
                artist.save
                role = "共演者"
                artist_ids << artist.id
              end
            end
           elsif ele[0] == "指"
            role = "指揮者"
            artist_name = ele.split("／", 2)[1]
            artist = Artist.where(artist_name: artist_name)first_or_initialize
            artist.save
            cond_id = artist.id
          elsif ele[0] == "管"
            #何もしない
          elsif ele[0] == "共"
            #処理
            artists = ele.split("／", 2)[1].split      #独は複数いる場合があるので、／で割って、さらに空白で割る。
            artists.each do |art|
              if art[0] == "他"     #eleの中身が"出／古部賢一ob 他"みたいなときの処理。とりあえず後回し（共のとこも同じ）。
                #現状何もしない
              else
                role = "共演者"
                artist_name = art.scan(/[^a-zA-ZＡ-Ｚ]/).join  #アルファベット以外の文字列を配列で取り、連結。
                short_name = art.scan(/[a-zA-ZＡ-Ｚ]/).join  #これは、obとかvlnとか。アルファベットの文字列を配列で取り、連結。
                #もう一回考える。まずInstrumentalテーブルに保存してから、idをとってくる。
                instrument = Instrument.where(short_name: short_name).first_or_initialize
                instrument.save
                inst_id = instrument.id
                artist = Artist.where(artist_name: artist_name).first_or_initialize
                artist.save
                artist_ids << artist.id
              end
            end
          elsif ele[0] == "司"
            #処理現状とりあえずroleは共演
            role = "共演者"
            artist_name= ele.split("／", 2)[1].split
            artist = Artist.where(artist_name: artist_name).first_or_initialize
            artist.save
            artist_ids << artist.id
          elsif ele[0]"出"
            #出の場合、楽器名がないのでとりあえず名前だけ保存
            artists = ele.split("／", 2)[1].split
            artists.each do |art|
              if art[0] == "他"
                #現状何もしない
              else
                role = "共演者"
                artist_name = art
                artist = Artist.where(artist_name: artist_name).first_or_initialize
                artist.save
                artist_ids << artist.id
              end
            end
          end
        end
      end
      place = Place.where(place_name: place_name).first_or_initialize
      place.save
      place_id = place.id
      # ここでコンサートテーブルのレコードを保存
    end
  end






  def get_jpo_concert(links)
    agent = Mechanize.new
    page = agent.get('http://search.ebravo.jp' + links)
    njp_key_title = page.at('#detail_area h2').inner_text     #新日本フィルかどうか判定するためタイトルをとる
    njp_key_content = page.search('tr[4] p').inner_text
    if njp_key_title.index("新日本") || njp_key_content.index("新日本")
      # 何もしない
    else
      # 普通のスクレイピング
      title = page.search('h2').inner_text
      day = page.search('.w290 p').inner_text
      advance_sale_day = page.search('.w280 p').inner_text if page.search('.w280 p')
      start_time = page.search('tr[2] td[2] p').inner_text
      place_name = page.search('tr[3] td[2] p').inner_text
      # ここまでは全て共通
      concert_elements = page.search('tr[4] p')  #公演情報のpタグをとる。
      texts = []                                 #公演情報をそれぞれ文字列にして入れる配列
      concert_elements.each do |ele|             #その処理。
        texts << ele.inner_text
      end
      texts.each do |text|
        if text[0] == "料"
          price = text.split("／")[1]
          puts price
        elsif text[0] == "問"
          contact_texts = text.split("／", 2)[1]#まず／で分割して"問／"を除く
          contact_text = contact_texts.split[0]     #複数は厄介だから最初のだけ
          contact_name = contact_text.split("0")[0]       #市街局番の０をキーにして電話番号と名前を分割。ここでは問い合わせ先をcontact_nameに。
          tel = "0" + contact_text.split("0", 2)[1]         #電話番号は分割に使った0を先頭につけたして。
          puts contact_name
          puts tel
        elsif text[0] == "※"
          others = text
        elsif text[0] == "曲"
          program = text.split("／", 2)[1]
          #ここまでは、<p>の中に／がひとつだけのもの。以下はそれ以外で
        else
          elements = text.split("　")      #<p>タグの中身を全角スペースのところで区切って配列に入れる。
          elements.each do |ele|
            if ele[0] == "合"
              choruses = ele.split("／", 2)[1].split
              choruses.each do |chor|
                artist_name = chor    #ここで.saveしないとだめ！！！！！！！！！！
              end
              role = "合唱"
            elsif ele[0] == "独"
              artists = ele.split("／", 2)[1].split      #独は複数いる場合があるので、／で割って、さらに空白で割る。
              artists.each do |artist|
                artist_name = artist.scan(/[^a-zA-ZＡ-Ｚ]/).join  #アルファベット以外の文字列を配列で取り、連結。
                short_inst_name = artist.scan(/[a-zA-ZＡ-Ｚ]/).join  #アルファベットの文字列を配列で取り、連結。
              end
            elsif ele[0] == "指"
              role = "指揮者"
              artist_name = ele.split("／", 2)[1]
            elsif ele[0] == "管"
              #何もしない
            elsif ele[0] == "共"
              #処理
            elsif ele[0] == "司"
              #処理
            end
          end
        end
      end
    end

  end

end