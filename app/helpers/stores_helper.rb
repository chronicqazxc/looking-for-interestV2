module StoresHelper
	def get_store_name(store_id)
		store = Store.find_by_store_id(store_id)
		store.name
	end

	def get_last_store_id_by_major_and_minor(major, minor)
		if (major && minor)
			stores = Store.where("major_type_id = ? AND minor_type_id = ?", major.type_id, minor.type_id)
    		if stores.count > 0
      			last_store_id = stores.last.store_id
    		else
      			# last_store_id = "#{@store_id_part1.type_id}_#{@store_id_part2.type_id}_"
      			last_store_id = "#{major.type_id}_#{minor.type_id}_"
    		end
    	end
	end
end
