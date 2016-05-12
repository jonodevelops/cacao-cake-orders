class AddMessagePhotoColumnsToOrders < ActiveRecord::Migration
  def change
  	add_attachment :orders, :message_photo
  end
end
