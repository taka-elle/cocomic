class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth if Rails.env.production?


  def authenticate_any!
    if shop_signed_in?
        true
    else
        authenticate_user!
    end
  end
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name,:area_id,:city,:add_line,:build])
    devise_parameter_sanitizer.permit(:account_update,keys: [:name,:area_id,:city,:add_line,:build])
  end

  def shop_to_top
    redirect_to root_path if shop_signed_in?
  end

  def user_to_top
    redirect_to root_path if user_signed_in?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end 
