class MajorType < ActiveRecord::Base
	has_many :minor_types, dependent: :destroy
	has_many :stores, dependent: :destroy
	has_one :parse_json, dependent: :destroy
end
