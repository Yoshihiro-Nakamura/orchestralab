class CreateOrchestras < ActiveRecord::Migration
  def change
    create_table :orchestras do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
