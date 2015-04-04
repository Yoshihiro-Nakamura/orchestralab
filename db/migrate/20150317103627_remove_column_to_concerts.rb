class RemoveColumnToConcerts < ActiveRecord::Migration
  def change
    remove_column :concerts, :soloist_id
  end
end
