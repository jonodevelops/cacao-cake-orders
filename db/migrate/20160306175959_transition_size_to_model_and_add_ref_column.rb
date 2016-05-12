class TransitionSizeToModelAndAddRefColumn < ActiveRecord::Migration
  def change
  	create_table :cake_sizes do |t|
  		t.string :name, null: false

      	t.timestamps null: false
  	end    
  
  	remove_column :orders, :cake_size, :string
  	add_belongs_to :orders, :cake_size, index: true

  end
end
