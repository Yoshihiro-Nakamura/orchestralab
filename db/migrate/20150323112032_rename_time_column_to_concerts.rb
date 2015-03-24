class RenameTimeColumnToConcerts < ActiveRecord::Migration
  def change
    rename_column :concerts, :time, :datetime
  end
end
