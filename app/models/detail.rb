class Detail < ActiveRecord::Base
	belongs_to :store, dependent: :destroy
end
