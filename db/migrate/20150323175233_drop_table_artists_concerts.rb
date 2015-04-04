class DropTableArtistsConcerts < ActiveRecord::Migration
  def change
    drop_table :artists_concerts
  end
end
