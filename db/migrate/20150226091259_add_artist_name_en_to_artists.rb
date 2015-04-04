class AddArtistNameEnToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :artist_name_en, :string
  end
end
