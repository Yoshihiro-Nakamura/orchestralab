class RenameRoleIdColumnToArtists < ActiveRecord::Migration
  def change
    rename_column :artists, :role_id, :role
  end
end
