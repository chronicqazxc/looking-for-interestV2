class Store < ActiveRecord::Base
	belongs_to :major_type
	belongs_to :minor_type
	belongs_to :parse_json
	has_one :detail, dependent: :destroy
	has_many :comments, dependent: :destroy
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	self.per_page = 10
end
