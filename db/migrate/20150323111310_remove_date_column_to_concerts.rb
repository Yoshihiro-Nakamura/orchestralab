class RemoveDateColumnToConcerts < ActiveRecord::Migration
  def change
    remove_column :concerts, :day
  end
end
