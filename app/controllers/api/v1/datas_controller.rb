class Api::V1::DatasController  < ApplicationController
    skip_before_filter :verify_authenticity_token
    respond_to :json

  def get_stores
    stores = Store.where("major_type_id = ? AND minor_type_id = ?", params[:major_type_id], params[:minor_type_id])
    render :status => 200, :json => {:stores => stores}
  end

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

  def get_major_types
    data = MajorType.all
    render json: data
  end

  def get_minor_types
    data = MinorType.where('major_type_id' => params[:major_type_id])
    render json: data
  end

  def get_stores_from_my_position
    stores = Store.where("major_type_id = ? AND minor_type_id = ?", params[:major_type_id], params[:minor_type_id])
    @stores = stores.near([params[:latitude], params[:longitude]], params[:range], :units => :km)
    render :json => @stores
  end  
end