class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :title
      t.string :day
      t.time :time
      t.integer :place_id
      t.integer :orchestra_id
      t.integer :soloist_id
      t.string :tag
      t.string :price
      t.string :ask
      t.string :ask_number

      t.timestamps null: false
    end
  end
end
