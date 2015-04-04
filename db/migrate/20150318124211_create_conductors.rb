class CreateConductors < ActiveRecord::Migration
  def change
    create_table :conductors do |t|
      t.string :cond_name
      t.string :image_url
      t.string :cond_name_en

      t.timestamps null: false
    end
  end
end