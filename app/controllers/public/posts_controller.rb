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
    @post = Post.new(post_params.except(:tag_names))
    @post.postable = current_shop || current_customer

    if @post.save
      @post.tags = find_or_create_tags(post_params[:tag_names])
      redirect_to @post, notice: "投稿が作成されました"
    else
      render :new, alert: "ログインしてください"
    end
  end
  
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def search
    @keyword = params[:keyword]
    @tag_id = params[:tag_id]
    if @keyword.blank? && @tag_id.blank?
      @posts = Post.none
      flash.now[:alert] = "検索キーワードまたはタグを入力してください。"
    else
      @posts = Post.order(created_at: :desc)
      if @keyword.present?
        @posts = @posts.where("title LIKE :keyword OR body LIKE :keyword", keyword: "%#{@keyword}%")
      end

      if @tag_id.present?      
        @posts = @posts.joins(:tags).where(tags: { id: @tag_id }).distinct
      end
    end
      @posts = @posts.order(created_at: :desc).page(params[:page])
      @tags = Tag.all
      
      render :index
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params.except(:tag_names))
      @post.tags = find_or_create_tags(post_params[:tag_names])
      redirect_to post_path(@post), notice: "投稿を更新しました。"
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

  def find_or_create_tags(tag_names)
    return [] if tag_names.blank?

    tag_names.split(',').map(&:strip).uniq.map do |name|
      Tag.find_or_create_by(name: name)
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :address, :tag_names)
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
