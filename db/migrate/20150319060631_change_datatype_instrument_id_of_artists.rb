class ChangeDatatypeInstrumentIdOfArtists < ActiveRecord::Migration
  def change
    change_column :artists, :instrument_id, :integer
  end
end
