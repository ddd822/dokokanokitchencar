class Public::PostsController < ApplicationController
  before_action :authenticate_shop!, only: [:create], if: -> { shop_signed_in? }
  before_action :authenticate_customer!, only: [:create], if: -> { customer_signed_in? }

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
      render :new
    end
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
