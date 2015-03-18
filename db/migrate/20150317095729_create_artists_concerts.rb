class CreateArtistsConcerts < ActiveRecord::Migration
  def change
    create_table :artists_concerts do |t|
      t.integer :artist_id
      t.integer :concert_id
    end
  end
end
