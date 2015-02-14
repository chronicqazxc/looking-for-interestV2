module StoresHelper
	def get_store_name(store_id)
		if (store_id)
			store = Store.find(store_id)
			store.name
		else
			""
		end
	end

	def get_last_store_id_by_major_and_minor(major, minor)
		if (major && minor)
			stores = Store.where("major_type_id = ? AND minor_type_id = ?", major.id, minor.id)
    		if stores.count > 0
      			last_store_id = stores.last.id
    		else
      			# last_store_id = "#{@store_id_part1.type_id}_#{@store_id_part2.type_id}_"
      			last_store_id = "#{major.id}_#{minor.id}_"
    		end
    	end
	end
end
