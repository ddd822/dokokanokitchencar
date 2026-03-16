class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :choose_layout


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


  private

  def choose_layout
    if shop_signed_in?
      "shop"
    else
      "application"
    end
  end
end
