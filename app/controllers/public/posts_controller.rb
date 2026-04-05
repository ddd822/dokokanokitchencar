class Public::PostsController < ApplicationController
  before_action :authenticate_user!,  only: [:new, :edit, :update, :destroy]
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

  def search
    @keyword = params[:keyword]
    if @keyword.present?
      @posts = Post.where("title LIKE :keyword OR body LIKE :keyword", keyword: "%#{@keyword}%")
                    .order(created_at: :desc)
    else
      flash.now[:alert] = "検索キーワードを入力してください"
      @posts = Post.order(created_at: :desc)
    end
      render :index
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
    if shop_signed_in?
      redirect_to shop_path(current_shop), notice: "投稿を削除しました。"
    elsif customer_signed_in?
      redirect_to customer_path(current_customer), notice: "投稿を削除しました。"
    end
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

  def current_postable
    if shop_signed_in?
      current_shop
    elsif customer_signed_in?
      current_customer
    else
      nil
    end
  end

  def authorize_post!
    unless @post.postable == current_postable
      redirect_to posts_path, alert: "編集・削除の権限がありません。"
    end
  end

  def authenticate_user!
    unless shop_signed_in? || customer_signed_in?
      redirect_to root_path, alert: "ログインしてください。"
    end
  end

end
