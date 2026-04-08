class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_customer!, only: [:show, :edit, :update, :destroy]

  def show
    @posts = @customer.posts.order(created_at: :desc).page(params[:page])
    @comments = @customer.comments.includes(:commentable).order(created_at: :desc).page(params[:page])
  end
  
  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "ユーザープロフィールを更新しました。"
    else
      flash.now[:alert] = '更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @customer.destroy
    sign_out @customer
    redirect_to root_path, notice: '退会処理が完了しました。ご利用ありがとうございました。'
  end

  private

  def customer_params
    permitted = [:name, :email]
    # パスワードが空の場合は除外し、入力があれば許可する
    if params[:customer][:password].present?
      permitted += [:password, :password_confirmation]
    end
    params.require(:customer).permit(permitted)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "該当するユーザーが見つかりません。"
  end

  def authorize_customer!
    unless @customer == current_customer
      redirect_to customer_path(current_customer), alert: "権限がありません。"
    end
  end

end
