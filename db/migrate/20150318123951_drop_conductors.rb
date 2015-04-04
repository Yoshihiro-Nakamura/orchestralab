class DropConductors < ActiveRecord::Migration
  def change
    drop_table :conductors
  end
end
