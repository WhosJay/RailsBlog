class CommentsController < ApplicationController
  def create
    Comment.create(user_id: current_user.id, post_id: params[:comment][:id], combody: params[:comment][:combody])
    flash[:notice] = "Your comment has been added to the post!"
    redirect_to post_path(params[:comment][:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Your comment has been deleted"
    redirect_to post_path(@comment.post.id)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def show
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(combody: params[:comment][:combody])
    flash[:notice] = "Your comment is successfully Updated."
    redirect_to post_path(@comment.post.id)
  end
  
end
