class MenusController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:get_init_menus, :get_ranges]	
  def get_init_menus
  	first_major_type = MajorType.first
  	minor_types = MinorType.where('major_type_id' => (first_major_type.type_id))
  	stores = Store.where("major_type_id = ? AND minor_type_id = ?", first_major_type.type_id, minor_types.first.type_id)

  	data = { "Titles" => ["大類","小類","範圍"], 
  			 "MajorType" => first_major_type, 
  			 "MinorType" => minor_types.first, 
  			 "Store" => stores.first,
  			 "Range" => "0.5",
         "NumberOfRows" => "3" }
  	# render json: data
    render :plain => "123"
  end

  def get_ranges
    render json: ["0.5","1.0","2.0","5.0"]
  end
end