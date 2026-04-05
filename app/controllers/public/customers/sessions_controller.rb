# frozen_string_literal: true

class Public::Customers::SessionsController < Devise::SessionsController
  before_action :redirect_if_shop_logged_in, only: [:new, :create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end

  private

  def redirect_if_shop_logged_in
    if shop_signed_in?
      redirect_to shop_path(current_shop), alert: "店舗ユーザーでログイン中にはアクセスできません。"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
