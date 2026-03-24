class Admin::PostsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def index
    @posts = Post.all
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
