# frozen_string_literal: true

class Public::Shops::SessionsController < Devise::SessionsController
  before_action :redirect_if_customer_logged_in, only: [:new, :create]
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
    shop_path(current_shop)
  end

  private

  def redirect_if_customer_logged_in
    if customer_signed_in?
      redirect_to customer_path(current_customer), alert: "一般ユーザーでログイン中にはアクセスできません。"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
