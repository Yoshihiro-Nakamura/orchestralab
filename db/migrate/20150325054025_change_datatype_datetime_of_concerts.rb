class ChangeDatatypeDatetimeOfConcerts < ActiveRecord::Migration
  def change
    change_column :concerts, :datetime, :datetime
  end
end
