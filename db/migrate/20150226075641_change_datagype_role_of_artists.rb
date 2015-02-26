class ChangeDatagypeRoleOfArtists < ActiveRecord::Migration
  def change
    change_column :artists, :role, :string
  end
end
