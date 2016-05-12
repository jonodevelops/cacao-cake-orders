class CakeSize < ActiveRecord::Base

	has_many :orders, inverse_of: :cake_size

	before_destroy :check_for_orders

private

	def check_for_orders
		if orders.any?
			errors[:base] << "cannot delete Cake Style that has orders"
		return false
		end
	end
end
