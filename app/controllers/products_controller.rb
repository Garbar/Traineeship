class ProductsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_product, only: [:show]

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
