module DetailsHelper
	def destroy_detail_by_store(store_id)
    	detail = Detail.find_by_store_id(store_id)
    	detail.destroy
	end
end
