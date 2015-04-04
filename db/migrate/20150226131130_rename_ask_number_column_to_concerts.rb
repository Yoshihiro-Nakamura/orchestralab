class RenameAskNumberColumnToConcerts < ActiveRecord::Migration
  def change
    rename_column :concerts, :ask_number, :contact_number
  end
end
