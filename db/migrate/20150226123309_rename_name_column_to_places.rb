class RenameNameColumnToPlaces < ActiveRecord::Migration
  def change
    rename_column :places, :name, :place_name
  end
end
