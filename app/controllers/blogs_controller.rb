class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @blogs = Blog.all
  end
  
  def new
    @blog = Blog.new
  end
  
  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        #ContactMailer.contact_mail(@blog).deliver
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    #binding.irb
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "投稿を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"投稿を削除しました！"
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end
  
  private
  def blog_params
    params.require(:blog).permit(:content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def ensure_correct_user
    @blog = Blog.find(params[:id])
    if current_user.id != @blog.user_id
      redirect_to blogs_path
    end
  end
end
