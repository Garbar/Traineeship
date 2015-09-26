class RegistrationsController < ApplicationController
  before_action :deny_user
  def index

  end
  def user
    @role = FormUser.new
  end
  def customer
    @role = FormCustomer.new
  end
  def admin
    @role = FormAdmin.new
  end
  def create_user
    @role = FormUser.new(user_form_params)
    create(@role.save)
  end
  def create_customer
    @role = FormCustomer.new(customer_form_params)
    create(@role.save)
  end
  def create_admin
    @role = FormAdmin.new(admin_form_params)
    create(@role.save)
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
  def deny_user
    if user_signed_in?
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to root_path
    end
  end

  private

  def create(role)
    if role
      Rails.logger.debug "Role.save: #{role}"
      @user = User.find_by id: role
      sign_in(@user)
      redirect_to root_path, notice: "User has been created"
    else
      render :index
    end
  end


  # Using strong parameters
  def user_form_params
    params.require(:form_user).permit(:email, :password_confirmation, :password)
  end
  def customer_form_params
    params.require(:form_customer).permit(:email, :password_confirmation, :password, :avatar, :shop_name)
  end
  def admin_form_params
    params.require(:form_admin).permit(:email, :password_confirmation, :password, :avatar, :name, :surname, :date_birth, :passport)
  end
end
