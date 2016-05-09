class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:id])
    Comment.create(user_id: current_user.id, post_id: @post, body: params[:combody])
    flash[:notice] = "Your comment has been added to the post!"
    redirect_to post_path(@post)
  end

  def destroy
  end

  def edit
  end

  def show
  end

  def update
  end
end
