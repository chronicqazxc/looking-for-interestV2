module MajorTypesHelper
	def get_major_type_desc(major_type_id)
		if MajorType.all.count > 0
			major_type_description = MajorType.find(major_type_id).type_description
		else
			major_type_description = ""
		end
	end	
end
