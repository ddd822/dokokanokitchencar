class Public::PostsController < ApplicationController
  before_action :authenticate_shop!, only: [:create], if: -> { shop_signed_in? }
  before_action :authenticate_customer!, only: [:create], if: -> { customer_signed_in? }
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post!, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if shop_signed_in?
      @post.postable = current_shop
    elsif customer_signed_in?
      @post.postable = current_customer
    else
      redirect_to root_path, alert: "ログインしてください" and return
    end
    if @post.save
      redirect_to @post, notice: "投稿が作成されました"
    else
      render :new, alert: "ログインしてください。"
    end
  end
  
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: "投稿が見つかりません。"
  end

  def authorize_post!
    unless @post.postable == current_postable
      redirect_to posts_path, alert: "編集・削除の権限がありません。"
    end
  end

end
