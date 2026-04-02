class Admin::ShopsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def index
    @shops = Shop.all
  end

  def search
    @keyword = params[:keyword]
    if @keyword.present?
      @shops = Shop.where("name LIKE :keyword OR email LIKE :keyword", keyword: "%#{@keyword}%")
                    .order(created_at: :desc)
    else
      @shops = Shop.none
    end
    render :index
  end

  def show
    @shop = Shop.find(params[:id])
    @posts = @shop.posts.order(created_at: :desc)
  end

  def destroy
    @shop = Shop.find_by_id(params[:id])
    @shop.destroy if @shop
    flash[:notice] = "店舗ユーザーを削除しました"
    redirect_to admin_customers_path
  end
  
end
