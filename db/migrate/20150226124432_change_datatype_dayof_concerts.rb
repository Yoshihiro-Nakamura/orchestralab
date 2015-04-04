class ChangeDatatypeDayofConcerts < ActiveRecord::Migration
  def change
    change_column :concerts, :day, :date
  end
end
