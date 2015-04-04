class ChangeDatagypeInstIdOfArtists < ActiveRecord::Migration
  def change
    change_column :artists, :inst_id, :string
  end
end
