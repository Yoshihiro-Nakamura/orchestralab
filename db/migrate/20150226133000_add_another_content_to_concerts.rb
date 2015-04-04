class AddAnotherContentToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :another_content, :string
  end
end
