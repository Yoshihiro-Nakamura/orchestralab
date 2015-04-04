class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :name2
      t.string :name3
      t.string :name4
      t.string :name5
      t.integer :role_id
      t.integer :instrument_id
      t.string :image_url

      t.timestamps null: false
    end
  end
end
