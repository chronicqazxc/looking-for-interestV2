class Comment < ActiveRecord::Base
	belongs_to :store, dependent: :destroy
end
