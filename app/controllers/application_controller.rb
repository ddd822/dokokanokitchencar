class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_tags_for_search
  layout :choose_layout


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


  private

  def set_tags_for_search
    @tags = Tag.joins(:posts).distinct.order(:name)
  end

  def choose_layout
    if shop_signed_in?
      "shop"
    else
      "application"
    end
  end
end
