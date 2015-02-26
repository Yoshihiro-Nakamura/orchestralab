class RenameNameColumnToInstruments < ActiveRecord::Migration
  def change
    rename_column :instruments, :name, :inst_name
  end
end
