class StoresController < ApplicationController
  include CommentsHelper, DetailsHelper, StoresHelper
  helper :major_types, :minor_types

  def menu
    if MajorType.first
      first_major_type = MajorType.first
      @major_type_id = first_major_type.id
      if MinorType.find_by_major_type_id(first_major_type.id)
        first_minor_type = MinorType.find_by_major_type_id(first_major_type.id)
        @minor_type_id = first_minor_type.id
        @stores = Store.where("major_type_id = ? AND minor_type_id = ?", first_major_type.id, first_minor_type.id).paginate(:page => params[:page])
      else
        @minor_type_id = ""
        @stores = Store.where("major_type_id = ?", first_major_type.id)
      end
    else
      @stores = Store.all
    end    
  end

  def index
    # @stores = Store.all
    # render :plain => params
    major_type_id = params[:major_type_id]
    minor_type_id = params[:minor_type_id]
    if major_type_id != ""
      first_major_type = MajorType.find(major_type_id.to_i)
      if MinorType.find(minor_type_id.to_i)
        first_minor_type = MinorType.find(minor_type_id.to_i)
        @stores = Store.where("major_type_id = ? AND minor_type_id = ?", first_major_type.id, first_minor_type.id).paginate(:page => params[:page])
      else
        @stores = Store.where("major_type_id = ?", first_major_type.id).paginate(:page => params[:page])
      end
    else
      @store = Store.new
      render :action => 'new' 
      # render :plain => "not found"
    end

    @current_page = params[:page]
  end

  def show
    @store = Store.find(params[:id])
    @current_page = params[:page]
  end

  def new
    @store = Store.new
    @type = "new"
    # render plain: @minor_types.to_json
  end

  def create
    # render plain: store_type_params
    @type = "create"
    params_for_create = store_type_params
    # if params_for_create[:minor_type_id].include? "_"
    #   major_type_id = params_for_create[:minor_type_id].split("_").first
    #   minor_type_id = params_for_create[:minor_type_id].split("_").last
    #   params_for_create[:minor_type_id] = minor_type_id
    # end
    # params_for_create[:store_id] = "#{params_for_create[:major_type_id]}_#{params_for_create[:minor_type_id]}_#{params_for_create[:store_id]}"
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
    @store.destroy
    redirect_to stores_url, :notice => "Successfully destroyed store."
  end

## ajax methods
# add & modify form
  def get_minor_types
    # @params = params
    #   respond_to do |format|
    #     format.js {}
    #   end

    store = params[:store]
    @major_type_id = store[:major_type_id]
    
    if MinorType.where('major_type_id' => (store[:major_type_id])).count > 0
      @minor_types = MinorType.where('major_type_id' => (store[:major_type_id]))
      @minor_type_id = @minor_types.first.id
      @minor_type_arr = []
      @minor_types.each do |minor_type|
        @minor_type_arr.push([minor_type.type_description, minor_type.id])
      end
      respond_to do |format|
        format.js {}
      end
    else
      @minor_type_arr = []
      # render plain: "faild"
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

# index
##

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
    params.require(:store).permit(:name, :phone_number, :address, :major_type_id, :minor_type_id, :latitude, :longitude)
  end   
end