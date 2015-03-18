class RenameConducterToConductor < ActiveRecord::Migration
  def change
    rename_table :conducters, :conductors
  end
end
