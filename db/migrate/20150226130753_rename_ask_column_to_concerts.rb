class RenameAskColumnToConcerts < ActiveRecord::Migration
  def change
    rename_column :concerts, :ask, :contact_name
  end
end
