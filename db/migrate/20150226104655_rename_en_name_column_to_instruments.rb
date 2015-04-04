class RenameEnNameColumnToInstruments < ActiveRecord::Migration
  def change
    rename_column :instruments, :en_name, :inst_name_en
  end
end
