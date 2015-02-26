class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.string :name
      t.string :name2
      t.string :name3
      t.string :short_name
      t.string :short_name2
      t.string :short_name3
      t.string :en_name

      t.timestamps null: false
    end
  end
end
