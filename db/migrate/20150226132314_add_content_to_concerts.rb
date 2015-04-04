class AddContentToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :content, :string, :limit=>700
  end
end
