class AddOrchNameEnToOrchestras < ActiveRecord::Migration
  def change
    add_column :orchestras, :orch_name_en, :string
  end
end
