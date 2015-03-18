class ChangeDatatypeConductorIdOfConcerts < ActiveRecord::Migration
  def change
    change_column :concerts, :conductor_id, :integer
  end
end
