class UsersController < ApplicationController
 before_action :ensure_correct_user, only: [:new, :show, :edit, :update]
    def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new 
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def ensure_correct_user
    @user = User.find_by(user_params)
    if @user.user_id != current_user.id
      redirect_to("/users/:id")
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image, :image_cache, :id)
  end
end
