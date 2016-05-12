class RemoveSpecialFromOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :special, :boolean
  end
end
