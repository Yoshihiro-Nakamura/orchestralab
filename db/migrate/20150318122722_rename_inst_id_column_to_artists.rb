class RenameInstIdColumnToArtists < ActiveRecord::Migration
  def change
    rename_column :artists, :inst_id, :instrument_id
  end
end
