class Public::ShopsController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_shop, only: [:show, :edit, :update]
  before_action :authorize_shop!, only: [:show, :edit, :update]

  def show
    @posts = @shop.posts.order(created_at: :desc)
  end
  
  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to @shop, notice: "プロフィールを更新しました。"
    else
      render :edit
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :email, :password, :password_confirmation)
  end

  def set_shop
    @shop = Shop.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "該当するユーザーが見つかりません。"
  end

  def authorize_shop!
    unless @shop == current_shop
      redirect_to root_path, alert: "権限がありません。"
    end
  end

end
