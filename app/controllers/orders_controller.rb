class OrdersController < ApplicationController
	before_action :allow_admin, only: [:destroy]
	before_action :load_select_objects


	def index
		@orders = Order.recent
		@orders_today = @orders.pickup_on(Time.zone.today)
		@orders_tomorrow = @orders.pickup_on(Time.zone.tomorrow)
		@recent_orders = @orders.recent
	end

	def show
		@order = Order.find(params[:id])
	end

	def new
		@order = Order.new({ cake_style_id: params[:cake_style_id] })

		if params[:cake_style_id]
		@cake_style = CakeStyle.find(params[:cake_style_id])
		@available_cake_styles << @cake_style
		end
		@cake_style ||= @available_cake_styles.first
	end

	def create
		set_deposit_balance
		@order = Order.new(order_params)

		if @order.save
			redirect_to @order
		else
			render 'new'
		end
	end

	def edit
		@order = Order.find(params[:id])
		@cake_style = @order.cake_style
		@available_cake_styles << @cake_style
	end

	def update
		set_deposit_balance
		@order = Order.find(params[:id])

		if @order.update(order_params)
			redirect_to @order
		else
			render 'edit'
		end	
	end

	def destroy
		@order = Order.find(params[:id])
		if @order.cancelled
		  if @order.destroy
		  	redirect_to :orders, notice: 'Order was successfuly destroyed'
		  end
		else
			redirect_to @order, notice: 'Order must be cancelled before destroyed'
		end
	end

	def cancel_switch
		@order = Order.find(params[:id])
		switched_state = !@order.cancelled
		if @order.update(cancelled: switched_state)
			flash[:notice] = 'Order Updated Successfuly'
			redirect_back_or_default
		else
			flash[:notice] = 'Order Could Not Be Updated'
			redirect_back_or_default
		end	
		
	end

	def daily_orders
	   	if (params[:date]).present?
			@date = Date.parse(params[:date])
		else
			@date = Time.zone.today
		end
	    @orders = Order.pickup_on(@date).by_style.by_size
	end

	def daily_messages
		if (params[:date]).present?
			@date = Date.parse(params[:date])
		else
			@date = Time.zone.today
		end
	    @orders = Order.pickup_on(@date)
	end

	def search
		@orders = Order.recent
		if params[:uncurrent].present?
			@orders = @orders.uncurrent_styles
			@uncurrent_checked = true
		end
		if params[:uncancelled].present?
			@orders = @orders.uncancelled
			@uncancelled_checked = true
		end
		if params[:pickup_start_date].present? && params[:pickup_end_date].present?
			@pickup_start_date = params_date(:pickup_start_date)
			@pickup_end_date = params_date(:pickup_end_date)
			@orders = @orders.pickup_between(@pickup_start_date, @pickup_end_date)
		end
		if params[:order_location_id].present?
			@orders = @orders.orders_at(params[:order_location_id])
			@selected_order_location_id = params[:order_location_id]
		end
		if params[:pickup_location_id].present?
			@orders = @orders.pickups_at(params[:pickup_location_id])
			@selected_pickup_location_id = params[:pickup_location_id]
		end
		if params[:user_id].present?
			@orders = @orders.ordered_by(params[:user_id])
			@selected_user_id = params[:user_id]
		end
		if params[:customer_phone].present?
			@orders = @orders.find_by_phone(params[:customer_phone])
			@selected_customer_phone = params[:customer_phone]
		end
	end

private
	def order_params
		params.require(:order).permit(:customer_name, :customer_phone, :cake_style_id, :cake_size_id, :cake_message, :message_photo, :order_location_id, :order_date, :user_id, :pickup_location_id, :pickup_date, :pickup_time, :price, :deposit, :balance, :notes, :cancelled)
		
	end

	def load_select_objects
		@locations = Location.all
		@available_cake_styles = CakeStyle.current_styles
		@cake_sizes = CakeSize.all
		@current_user = User.find(session[:user_id])
		@users = User.sorted.staff.located_at(@current_user.location_id)
	end

	def set_deposit_balance
		if params[:order][:deposit].empty?
			params[:order][:deposit] = params[:order][:price]
		end

		price = params[:order][:price].to_i
		deposit = params[:order][:deposit].to_i
		params[:order][:balance] = price - deposit
	end



end
