class AddCondIdToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :cond_id, :string
  end
end
