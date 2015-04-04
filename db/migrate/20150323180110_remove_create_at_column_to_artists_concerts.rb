class RemoveCreateAtColumnToArtistsConcerts < ActiveRecord::Migration
  def change
    remove_column :artists_concerts, :created_at
    remove_column :artists_concerts, :updated_at
  end
end
