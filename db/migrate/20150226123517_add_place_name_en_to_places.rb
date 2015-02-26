class AddPlaceNameEnToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :place_name_en, :string
  end
end
