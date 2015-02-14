class DetailsController < ApplicationController
  helper :stores, :comments
  def index
    # render plain: params.keys.to_json
    @detail = Detail.find_by_store_id(params[:store_id])
    @store_id = params[:store_id]
  end

  def new
    @detail = Detail.new
    @store_id = params[:store_id]
  end

  def create
    # render plain: params
    @detail = Detail.new(detail_params)
    if @detail.save
      redirect_to @detail, :notice => "Successfully created detail."
    else
      render :action => 'new'
    end
  end

  def show
    @detail = Detail.find(params[:id])
  end

  def edit
    # render :plain => params
    @detail = Detail.find(params[:store_id])
    @store_id = params[:store_id]
  end

  def update
    @detail = Detail.find(params[:id])
    if @detail.update_attributes(detail_params)
      redirect_to @detail, :notice  => "Successfully updated minor_type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @detail = Detail.find(params[:id])
    @detail.destroy
    redirect_to details_url, :notice => "Successfully destroyed store."
  end

  private  
  def detail_params
    params.require(:detail).permit(:store_id, :icon_url, :image_url_1, :image_url_2, :image_url_3, :web_address, :open_time, :introduction)
  end  
end
