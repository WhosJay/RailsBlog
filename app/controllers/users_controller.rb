class UsersController < ApplicationController
  def create
    if params[:password] == params[:password2]
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "You are signed up and good to go, Welcome!"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Please make sure your passwords match."
      redirect_to users_path
    end
  end

  def destroy
    @user = current_user  
    @user.destroy
    session.clear
    flash[:notice] = "Your account has been deleted"
    redirect_to users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @user = User.where(email: params[:email]).first
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      flash[:notice] = "You've been signed in successfully."
      redirect_to user_path(current_user.id)
    elsif params[:email] || params[:password]
      flash[:alert] = "Invalid E-mail or Password, please Sign-up or try again."
    end
    @users = User.all
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @users = User.find(params[:id])
    @user = current_user
    @posts = Post.all
    @comments = Comment.all
  end

  def update
    @user = User.find(params[:id])
    if user_params[:password] == user_params[:password2]
      @user.update(euser_params)
      flash[:notice] = "Your Info is successfully Updated."
      redirect_to user_path(@user)
    else flash[:alert] = "Your PASSWORDS do not match!."
      redirect_to edit_user_path(@user)
    end
  end

  def logout
    session.clear
    flash[:notice] = "You are Logged off."
    redirect_to users_path
  end

  def profile
    @users = User.find(params[:id])
    @posts = Post.all
    @comments = Comment.all
    redirect_to(user_path) if current_user != nil && current_user.id == @users.id
  end

  private

  def user_params
    params.require(:user).permit(:password, :password2)
  end

  def euser_params
    params.require(:user).permit(:username, :email, :password)
  end

end
