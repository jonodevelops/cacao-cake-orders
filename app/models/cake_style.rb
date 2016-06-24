class CakeStyle < ActiveRecord::Base
	has_many :orders, inverse_of: :cake_style

	has_attached_file :style_photo, styles: { original: "500x500>", medium: "300x300>", thumb: "150x150#" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :style_photo, content_type: /\Aimage\/.*\Z/

  	scope :current_styles, -> { where("current = ?", true) }

  	scope :recent, -> { order(created_at: :desc)}

	def has_orders?
		orders.any?
	end


private



end
