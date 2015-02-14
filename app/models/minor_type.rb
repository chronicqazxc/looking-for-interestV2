class MinorType < ActiveRecord::Base
	belongs_to :major_type
	has_many :stores, dependent: :destroy
end
