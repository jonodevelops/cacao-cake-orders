class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string 	:customer_name#,		:null => false
    	t.string 	:customer_phone#,	:null => false
    	t.belongs_to	:cake_style,     index: true, null: false
    	t.string 	:cake_size		
    	t.text		:cake_message		
    	t.belongs_to  :order_location,   index: true, null: false
    	t.date		:order_date		      
    	t.belongs_to   :pickup_location, index: true, null: false
        t.date      :pickup_date         
    	t.time 		:pickup_time,        null: false, default: '2000-01-01 14:00:00'
    	t.integer	:price#,				:null => false
    	t.boolean	:paid_full,	         null: false, default: false
    	t.integer	:deposit
    	t.integer	:balance
        t.boolean   :special
    	t.text		:notes
        t.boolean   :cancelled,          null: false, default: false

      	t.timestamps null: false
    end
  end
end
