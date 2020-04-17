class SessionsController < ApplicationController
  # before_action :ensure_correct_user, only: [:new]
 
  def new
    if logged_in?
      user = User.find(session[:user_id])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
     end
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private

  # def ensure_correct_user
  #   @user = User.find(params[:id])
  #   if current_user.id != @user.id
  #     redirect_to blogs_path
  #   end
  # end
  
end
