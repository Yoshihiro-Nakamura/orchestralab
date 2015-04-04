class RenameOrchestraIdColumnToConcerts < ActiveRecord::Migration
  def change
    rename_column :concerts, :orchestra_id, :orch_id
  end
end
