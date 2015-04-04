class RenameOrchIdColumnToConcers < ActiveRecord::Migration
  def change
    rename_column :concerts, :orch_id, :orchestra_id
  end
end
