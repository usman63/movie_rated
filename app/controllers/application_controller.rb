class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_current_location, unless: :devise_controller?

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :first_name, :last_name, image_attributes: :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :current_password, :password, :password_confirmation, :first_name, :last_name, image_attributes: [:id, :image]])
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

end
