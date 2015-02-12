module CommentsHelper
	def get_total_rates_count(store_id)
		comments = get_all_comments_by_store_id(store_id)
		comments.count
	end
	def get_average_rate(store_id)
		comments = get_all_comments_by_store_id(store_id)
		total_rate = 0.0
		comments.each do |comment|
			total_rate += comment.rate
		end
		total_rate /= get_total_rates_count(store_id)
	end

	def destroy_comments_by_store(store_id)
		comments = get_all_comments_by_store_id(store_id)
		comments.each do |comment|
			comment.destroy	
		end
    	
	end

	private
	def get_all_comments_by_store_id(store_id)
		comments = Comment.where('store_id' => store_id)
	end
end
