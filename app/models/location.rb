class Location < ActiveRecord::Base
	
	#Associates order Location with Orders by FK in Order model.
	has_many :orders_at, :class_name => 'Order', :foreign_key => :order_location_id, inverse_of: :order_location
	#Associates order Location with Orders by FK in Order model.
	has_many :pickups_at, :class_name => 'Order', :foreign_key => :pickup_location_id, inverse_of: :pickup_location
	has_many :users, inverse_of: :location

	private

	def staff
		users.staff
		
	end

end
