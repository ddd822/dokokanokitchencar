class Admin::CustomersController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def search
    @keyword = params[:keyword]
    if @keyword.present?
      @customers = Customer.where("name LIKE :keyword OR email LIKE :keyword", keyword: "%#{@keyword}%")
                    .order(created_at: :desc)
    else
      @customers = Customer.none
    end
    render :index
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order(created_at: :desc).page(params[:page])
    @comments = @customer.comments.includes(:commentable).order(created_at: :desc).page(params[:page])
  end

  def destroy
    @customer = Customer.find_by_id(params[:id])
    @customer.destroy if @customer
    flash[:notice] = "一般ユーザーを削除しました"
    redirect_to admin_customers_path
  end
end
