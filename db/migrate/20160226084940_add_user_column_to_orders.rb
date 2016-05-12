class AddUserColumnToOrders < ActiveRecord::Migration
  def change
  	add_belongs_to :orders, :user, index: true
  end
end
