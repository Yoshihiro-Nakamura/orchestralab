class AddTitleNameEnToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :title_name_en, :string
  end
end
