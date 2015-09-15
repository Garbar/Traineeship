class ProductsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_product, only: [:show]
  def index
    @products = Product.order("created_at desc")
  end

  def new
    # @product = current_user.product
    # @product = Product.new
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
      :title, :description, :image
    )
  end
end
