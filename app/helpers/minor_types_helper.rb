module MinorTypesHelper
	def get_minor_type_desc(major_type_id, minor_type_id)
		minor_types = MinorType.where('major_type_id' => major_type_id)
		minor_type = minor_types.find_by_type_id(minor_type_id)
		minor_type.type_description
	end

	def get_first_minor_by_major(major)
		if (major)
			first_minor = MinorType.find_by_major_type_id(major.type_id)
		end
		first_minor
	end

	def get_last_minor_by_major(major)
		minors = MinorType.where('major_type_id = ?', major.type_id)
		last_minor = minors.last
	end
end
