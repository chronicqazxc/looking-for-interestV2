class CommentsController < ApplicationController
  helper :stores
  def index
    # render plain: params.keys.to_json
    @comments = Comment.where('store_id' => (params[:store_id]))
    @store_id = params[:store_id]
  end

  def new
    @comment = Comment.new
    @store_id = params[:store_id]
  end

  def create
    # render plain: params
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment, :notice => "Successfully created comment."
    else
      render :action => 'new'
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @store_id = params[:store_id]
  end

  def edit
    @comment = Comment.find(params[:id])
    @store_id = params[:store_id]
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      redirect_to @comment, :notice  => "Successfully updated comment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_url, :notice => "Successfully destroyed comment."
  end

  private  
  def comment_params
    params.require(:comment).permit(:store_id, :guest_name, :rate, :content)
  end  
end
