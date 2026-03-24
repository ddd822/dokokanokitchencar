class Admin::CustomersController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order(created_at: :desc)
  end

  def destroy
    @customer = Customer.find_by_id(params[:id])
    @customer.destroy if @customer
    flash[:notice] = "一般ユーザーを削除しました"
    redirect_to admin_customers_path
  end
end
