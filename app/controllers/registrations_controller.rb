class RegistrationsController < ApplicationController
  before_action :deny_user
  def index

  end
  def user
  end
  def customer
  end
  def admin
  end
  def create
    role = params[:role].to_s.classify.constantize
  end

  private

  def deny_user
    if user_signed_in?
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to root_path
    end
  end

end
