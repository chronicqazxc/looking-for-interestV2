class MajorType < ActiveRecord::Base
	has_many :minor_types, dependent: :destroy
	has_many :stores, dependent: :destroy
end
