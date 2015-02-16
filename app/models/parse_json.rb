class ParseJson < ActiveRecord::Base
	belongs_to :major_type
	belongs_to :minor_type
	has_many :stores, dependent: :destroy
end
