class ProductsController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_product, only: [:show, :purchase]

  def index
    if user_signed_in?
      @products = Product.order("created_at desc")
      .page(params[:page]).per(10)
    else
      @products = Product.order("created_at desc")
      .unpro
      .page(params[:page]).per(10)
    end
  end

  def new
    @product = current_user.products.build
  end

  def show
  end

  def create
    @product = current_user.products.build(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def purchase
    @buy = PurchaseService.new
    if @product.name_shop.blank?
      flash[:error] = 'This product is not for sale, apologize'
      redirect_to root_path
    else
      begin
        answer = @buy.call(current_user)
        flash[:notice] = "Thank you for shopping in our store!"
        Rails.logger.debug "GetPhotoService - answer: #{answer}"
        redirect_to root_path
        SendUser.mail_create(answer[0], current_user.email).deliver_now
        SendAdmin.mail_create(answer[1]).deliver_now
      rescue ErrorMessages::EmailError, ErrorMessages::RequestTimeoutError => e
        flash[:error] = e.message
        redirect_to @product
      rescue ErrorMessages::ImageError, ErrorMessages::AdminTimeoutError  => e
        SendAdminError.mail_create(current_user.email).deliver_now
        flash[:error] = e.message
        redirect_to @product
      end
    end
    # respond_to do |format|
    #   format.json { render json: {status: "ok", mess: message, title: title, error: error}}
    # end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :title, :description, :image, :pro
    )
  end
end
