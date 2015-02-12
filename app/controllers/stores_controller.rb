class StoresController < ApplicationController
  include CommentsHelper, DetailsHelper, StoresHelper
  helper :major_types, :minor_types
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
  end

  def new
    @store = Store.new
    get_origin_store_id_by_store(@store)
    # render plain: @minor_types.to_json
  end

  def create
    # render plain: store_type_params

    params_for_create = store_type_params
    if params_for_create[:minor_type_id].include? "_"
      major_type_id = params_for_create[:minor_type_id].split("_").first
      minor_type_id = params_for_create[:minor_type_id].split("_").last
      params_for_create[:minor_type_id] = minor_type_id
    end
    params_for_create[:store_id] = "#{params_for_create[:major_type_id]}_#{params_for_create[:minor_type_id]}_#{params_for_create[:store_id]}"
    # render plain: params_for_create

    @store = Store.new(params_for_create)
    if @store.save
      redirect_to @store, :notice => "Successfully created store."
    else
      render :action => 'new'
    end    
  end

  def edit    
    @store = Store.find(params[:id])
    get_origin_store_id_by_store(@store)
  end

  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(store_type_params)
      redirect_to @store, :notice  => "Successfully updated minor_type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    destroy_comments_by_store(@store.store_id)
    destroy_detail_by_store(@store.store_id)
    @store.destroy
    redirect_to stores_url, :notice => "Successfully destroyed store."
  end

  def get_minor_types
    store = params[:store]
    @store_id_part1 = MajorType.find_by_type_id(store[:major_type_id])
    @store_id_part2 = MinorType.find_by_major_type_id(store[:major_type_id])
    @last_store_id = get_last_store_id_by_major_and_minor(@store_id_part1, @store_id_part2)
    
    if @minor_types = MinorType.where('major_type_id' => (store[:major_type_id]))
      @minor_type_arr = []
      @minor_types.each do |minor_type|
        @minor_type_arr.push([minor_type.type_description, "#{@store_id_part1.type_id}_#{minor_type.type_id}"])
      end
      respond_to do |format|
        format.js {}
      end
    else
      render plain: "faild"
    end
  end

  def change_minor_type
    store = params[:store]
    # minor_types = MinorType.where('major_type_id' => (@store_id_part1.type_id))
    
    if store[:minor_type_id].include? "_"
      major_type_id = store[:minor_type_id].split("_").first
      minor_type_id = store[:minor_type_id].split("_").last
      minor_types = MinorType.where('major_type_id' => (major_type_id))
      @store_id_part2 = minor_types.find_by_type_id(minor_type_id)
      @last_store_id = get_last_store_id_by_major_and_minor(MajorType.find_by_type_id(major_type_id), @store_id_part2)
    else
      @store_id_part2 = MinorType.find_by_type_id(store[:minor_type_id])
      @major = MajorType.find_by_type_id(@store_id_part2.major_type_id)
      @last_store_id = get_last_store_id_by_major_and_minor(@major, @store_id_part2)
    end
    # @params = store[:minor_type_id]
    respond_to do |format|
        format.js {}
     end
  end

  skip_before_action :verify_authenticity_token, :only => [:get_locations, :get_stores_from_my_position, :get_stores]
  def get_locations
    @locations = Store.all
    # @location = @location.nearbys(10, :units => :km)   
    render json: @locations
  end

  def get_stores_from_my_position
    stores = Store.where("major_type_id = ? AND minor_type_id = ?", params[:major_type_id], params[:minor_type_id])
    @stores = stores.near([params[:latitude], params[:longitude]], params[:range], :units => :km)
    render json: @stores
  end

  def get_stores
    stores = Store.where("major_type_id = ? AND minor_type_id = ?", params[:major_type_id], params[:minor_type_id])
    render json: stores
  end

  private  
  def store_type_params
    params.require(:store).permit(:store_id, :name, :phone_number, :address, :major_type_id, :minor_type_id, :latitude, :longitude)
  end  

  def get_origin_store_id_by_store(store)
    if !(@store_id_part1 = MajorType.find_by_type_id(store.major_type_id))
      @store_id_part1 = MajorType.first
    end

    if !(@store_id_part2 = MinorType.find_by_type_id(store.minor_type_id))
      if (@store_id_part1)
        @store_id_part2 = MinorType.find_by_major_type_id(@store_id_part1.type_id)
      end
    end
  end  
end