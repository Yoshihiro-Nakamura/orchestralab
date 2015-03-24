class RemoveIdColumnToArtistsConcerts < ActiveRecord::Migration
  def change
    remove_column :artists_concerts, :id
  end
end
