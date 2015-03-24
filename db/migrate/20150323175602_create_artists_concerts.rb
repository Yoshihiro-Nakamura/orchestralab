class CreateArtistsConcerts < ActiveRecord::Migration
  def change
    create_table :artists_concerts, id: false do |t|
      t.integer :artist_id
      t.integer :concert_id

      t.timestamps null: false
    end
  end
end
