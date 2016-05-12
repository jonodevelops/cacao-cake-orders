class Order < ActiveRecord::Base
	has_many :comments, dependent: :destroy

	#Associates a Location with an Order as the order_location.
	belongs_to :order_location, :class_name => 'Location', :foreign_key => 'order_location_id', inverse_of: :orders_at
	#Associates a Location with an Order as the pickup_location.
	belongs_to :pickup_location, :class_name => 'Location', :foreign_key => 'pickup_location_id', inverse_of: :pickups_at
	#Associates a CakeStyle with an Order.
	belongs_to :cake_style, inverse_of: :orders
	#Associates a User with an Order.
	belongs_to :user, inverse_of: :orders
	#Associates a CakeSize with an Order.
	belongs_to :cake_size, inverse_of: :orders

	has_attached_file :message_photo,
		styles: { medium: "300x300>", thumb: "150x150>" },
		convert_options: { },
		default_url: "/images/:style/missing.png"

  	validates_attachment_content_type :message_photo, content_type: /\Aimage\/.*\Z/

	validates :customer_name, :customer_phone, :cake_style, :cake_size_id, :order_location, :order_date, :user, :pickup_location, :pickup_date, :user_id, :price, :deposit, :balance, presence: true
	validates :cake_message, presence: true, length: { maximum: 32 }, if: 'message_photo.blank?'
	validates :message_photo, presence: true, if: 'cake_message.blank?'

	#validates :message, presence: true,
	#					length: { maximum: 30 }

	#scope :orders_today, ->  { where(:pickup_date => Time.zone.today)}
	#scope :orders_tomorrow, ->  { where(:pickup_date => Time.zone.tomorrow)}

	# List all orders, descending by pickup_date.
	scope :sorted, ->  { order(pickup_date: :desc) }

	# Choose pickup_date(s). Expects 1 argument in date format for requested day(s).
	scope :pickup_on, -> (pickup_date) { where("pickup_date = ?", pickup_date) }

	scope :by_style, -> { order(cake_style_id: :asc) }

	scope :by_size, -> { order(cake_size_id: :asc) }

	# List all orders, descending by most recently updated
	scope :recent, ->  { order(updated_at: :desc) }

	# List upcoming orders including today
	scope :upcoming, ->  { where("pickup_date >= ?", Time.zone.today) }


	scope :current_styles, ->  { joins(:cake_style).where("cake_styles.current = ?", true) }
	
	#Scopes included in search bar
	scope :uncurrent_styles, ->  { joins(:cake_style).where("cake_styles.current = ?", false) }
	scope :uncancelled, ->  { where("cancelled = ?", false) }
	scope :pickup_between, -> (pickup_start_date, pickup_end_date) { where("pickup_date >= ?", pickup_start_date).where("pickup_date <= ?", pickup_end_date) }
	scope :orders_at, -> (order_location_id) { where("order_location_id = ?", order_location_id)}
	scope :pickups_at, -> (pickup_location_id) { where("pickup_location_id = ?", pickup_location_id)}
	scope :ordered_by, -> (user_id) { where('user_id = ?', user_id) }
	scope :find_by_phone, -> (customer_phone) { where('customer_phone LIKE ?', "%#{customer_phone}%") }

	scope :cancelled, -> { where('cancelled = ?', true) }
					

end

#:customer, :phone, :order_date, :pickup_date, :price