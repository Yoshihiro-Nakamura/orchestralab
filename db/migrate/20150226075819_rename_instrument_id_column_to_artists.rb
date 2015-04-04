class RenameInstrumentIdColumnToArtists < ActiveRecord::Migration
  def change
    rename_column :artists, :instrument_id, :inst_id
  end
end
