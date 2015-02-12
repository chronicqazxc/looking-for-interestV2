class MajorTypesController < ApplicationController

 def index
    @major_types = MajorType.all
  end

  def show
    @major_type = MajorType.find(params[:id])
  end

  def new
    @major_type = MajorType.new
  end

  def create
    @major_type = MajorType.new(major_type_params)
    if @major_type.save
      redirect_to @major_type , :flash => { :success => "Successfully created major_type." } #:notice => "Successfully created major_type."
    else
      render :action => 'new'
    end
    # render plain: @major_type
  end

  def edit
    @major_type = MajorType.find(params[:id])
  end

  def update
    @major_type = MajorType.find(params[:id])
    if @major_type.update_attributes(major_type_params)
      redirect_to @major_type, :notice  => "Successfully updated major_type."
    else
      render :action => 'edit', :notice  => "Updated major_type faild."
    end
  end

  def destroy
    @major_type = MajorType.find(params[:id])
    @major_type.destroy
    redirect_to major_types_url, :notice => "Successfully destroyed major_type."
  end

  skip_before_action :verify_authenticity_token, :only => [:get_major_types] 
  def get_major_types
    data = MajorType.all
    render json: data
  end

  private  
  def major_type_params
    params.require(:major_type).permit(:type_id, :type_description)
  end  
end
