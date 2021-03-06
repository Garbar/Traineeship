class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do
    redirect_to root_url, notice: "Permission Denied!"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:role, :surname, :shop_name, :date_birth,
                                                            :name, :passport, :avatar, :reset_password_token,
                                                            :email, :password, :password_confirmation) }
  end
end
