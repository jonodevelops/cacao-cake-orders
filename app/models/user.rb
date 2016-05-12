class User < ActiveRecord::Base
	has_secure_password

has_many :orders
belongs_to :location, inverse_of: :users

scope :sorted, -> { order(username: :asc) }
scope :staff, ->  { where('admin = ?', :false) }
scope :located_at, -> (location) { where('location_id = ?', location) }

end
