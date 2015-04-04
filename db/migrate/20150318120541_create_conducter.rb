class CreateConducter < ActiveRecord::Migration
  def change
    create_table :conducters do |t|
      t.string :cond_name
      t.string :image_url
      t.string :cond_name_en
    end
  end
end
