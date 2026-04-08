class Admin::PostsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page])
  end

  def search
    @keyword = params[:keyword]
    if @keyword.present?
      @posts = Post.where("title LIKE :keyword OR body LIKE :keyword", keyword: "%#{@keyword}%")
                    .order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
    render :index
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy if @post
    flash[:notice] = "投稿を削除しました"
    redirect_to admin_posts_path
  end
end
