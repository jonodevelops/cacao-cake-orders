class RemoveColumnsFromLocations < ActiveRecord::Migration
  def change
  	remove_column :locations, :phone, :string
  	remove_column :locations, :address, :text
  	change_column :locations, :name, :string, null: :false
  end
end
