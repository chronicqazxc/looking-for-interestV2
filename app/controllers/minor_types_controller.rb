class MinorTypesController < ApplicationController
  helper :major_types
  def index
    @minor_types = MinorType.all.order(:major_type_id)
  end

  def show
    @minor_type = MinorType.find(params[:id])
  end

  def new
    @minor_type = MinorType.new
    # render plain: @major_arr
  end

  def create
    @minor_type = MinorType.new(minor_type_params)
    if @minor_type.save
      redirect_to @minor_type, :notice => "Successfully created minor_type."
    else
      render :action => 'new'
    end
    # render plain: params
  end

  def edit    
    @minor_type = MinorType.find(params[:id]) 
  end

  def update
    @minor_type = MinorType.find(params[:id])
    if @minor_type.update_attributes(minor_type_params)
      redirect_to @minor_type, :notice  => "Successfully updated minor_type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @minor_type = MinorType.find(params[:id])
    @minor_type.destroy
    redirect_to minor_types_url, :notice => "Successfully destroyed minor_type."
  end

  def get_last_minor_type
    minor_type = params[:minor_type]
    major_type_id = minor_type[:major_type_id]
    @last_minor_type = MinorType.where('major_type_id = ?',major_type_id).last
    # @params = params
    respond_to do |format|
        format.js {}
     end    
  end
  before_action :generate_major_types, only:[:new, :edit]

  skip_before_action :verify_authenticity_token, :only => [:get_minor_types] 
  def get_minor_types
    data = MinorType.where('major_type_id' => params[:major_type_id])
    render json: data
  end

  private  
  def minor_type_params
    params.require(:minor_type).permit(:type_id, :type_description, :major_type_id)
  end

  def generate_major_types
    major_types = MajorType.all
    @major_arr = []
    major_types.each do |major_type|
      @major_arr.push([major_type.type_description, major_type.id])
    end
  end  
end
