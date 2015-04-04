class ChangeDatatypeSolistIdOfConcetts < ActiveRecord::Migration
  def change
    change_column :concerts, :soloist_id, :string
  end
end
