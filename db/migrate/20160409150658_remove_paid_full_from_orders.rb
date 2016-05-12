class RemovePaidFullFromOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :paid_full, :boolean
  end
end
