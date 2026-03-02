class ApplicationController < ActionController::Base
  layout :choose_layout

  private

  def choose_layout
    if shop_signed_in?
      "shop"
    else
      "application"
    end
  end
end
