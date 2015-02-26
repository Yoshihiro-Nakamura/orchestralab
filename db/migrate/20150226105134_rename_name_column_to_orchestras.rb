class RenameNameColumnToOrchestras < ActiveRecord::Migration
  def change
    rename_column :orchestras, :name, :orch_name
  end
end
