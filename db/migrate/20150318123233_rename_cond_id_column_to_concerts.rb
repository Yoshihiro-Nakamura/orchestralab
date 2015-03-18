class RenameCondIdColumnToConcerts < ActiveRecord::Migration
  def change
    rename_column :concerts, :cond_id, :conductor_id
  end
end
