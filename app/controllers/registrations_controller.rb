class RegistrationsController < ApplicationController
  before_action :deny_user
  def index

  end
  def user
    @role = FormUser.new
  end
  def customer
  end
  def admin
  end
  def create_user
    @role = FormUser.new(user_form_params)
    create(@role)
  end
  def create_customer

  end
  def create_admin

  end
  # def create
  #   # role = "form_#{params[:role]}".classify.constantize
  #   # param = "#{params[:role]}_form_params".classify.underscore
  #   @role = FormUser.new(user_form_params)
  #   # @role = role.new(eval(param))
  #   # @role = role.new(param)
  #   if @role.save
  #     redirect_to root_path, notice: "User has been created"
  #   else
  #     render :user
  #   end
  # end

  private

  def create(role)
    if role.save
      redirect_to root_path, notice: "User has been created"
    else
      render :index
    end
  end

  def deny_user
    if user_signed_in?
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to root_path
    end
  end


  # Using strong parameters
  def user_form_params
    params.require(:form_user).permit(:email, :password_confirmation, :password)
  end
end
