class CakeSize < ActiveRecord::Base

	has_many :orders, inverse_of: :cake_size

	def has_orders?
		orders.any?
	end

end
