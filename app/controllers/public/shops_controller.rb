class Public::ShopsController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :authorize_shop!, only: [:show, :edit, :update, :destroy]

  def show
    @posts = @shop.posts.order(created_at: :desc)
  end
  
  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to @shop, notice: "店舗プロフィールを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @shop.destroy
    sign_out @shop
    redirect_to root_path, notice: '退会処理が完了しました。ご利用ありがとうございました。'
  end

  private

  def shop_params
    permitted = [:name, :email, :telephone_number, :introduction, :weekday_ids => []]
    if params[:shop][:password].present?
      permitted += [:password, :password_confirmation]
    end
    params.require(:shop).permit(permitted)
  end

  def set_shop
    @shop = Shop.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "該当する店舗が見つかりません。"
  end

  def authorize_shop!
    unless @shop == current_shop
      redirect_to root_path, alert: "権限がありません。"
    end
  end

end
