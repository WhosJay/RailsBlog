class PostsController < ApplicationController
  def create
    Post.create(user_id: current_user.id, title: params[:title], body: params[:body])
    flash[:notice] = "Your post has been added to the feed!"
    redirect_to user_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Your post has been deleted"
    redirect_to user_path(current_user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @users = User.all
    @comments = Comment.all
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = "Your post is successfully Updated."
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
