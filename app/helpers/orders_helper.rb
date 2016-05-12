module OrdersHelper

	def cancel_switch(order)
		switched_state = order.cancelled ? 'RESTORE' : 'CANCEL'
		link_to "#{switched_state}", cancel_switch_order_path(order), method: 'patch', data: { confirm: 'Are you sure?' }, class: 'action'
	end

	def outstanding_balance?(order)
		order.balance > 0 ? content_tag(:div, "OUTSTANDING BALANCE  MOP#{order.balance}", class: 'status') : ''
	end

	def not_current_style?(order)
		order.cake_style.current ? '' : content_tag(:div, 'NOT CURRENT STYLE', class: 'status')
	end

	def cancelled?(order)
		order.cancelled ? content_tag(:div, 'CANCELLED', class: 'status') : ''
	end

	def pickup_link(order)
		link_to(order.pickup_location.name, location_path(order.pickup_location), class: 'action')
	end

	def cake_style_link(order)
		link_to(order.cake_style.name, cake_style_path(order.cake_style), class: 'action')
	end

end
