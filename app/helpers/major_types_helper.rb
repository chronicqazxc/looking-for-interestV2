module MajorTypesHelper
	def get_major_type_desc(major_type_id)
		major_type_description = MajorType.find_by_type_id(major_type_id).type_description
	end	
end
