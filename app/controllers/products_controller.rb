class ProductsController < ApplicationController
  include HTTParty
  before_action :authenticate_user!, :except => [:show, :index]
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
    if @product.name_shop.blank? && @product.pro?
      flash[:error] = 'This product is not for sale, apologize'
      redirect_to root_path
    else
      begin
        answer = @buy.call(current_user)
        flash[:notice] = "Thank you for shopping in our store!"
        Rails.logger.debug "GetPhotoService - answer: #{answer}"
        redirect_to profile_path
        SendUser.mail_create(answer[0], current_user.email).deliver_now
        SendAdmin.mail_create(answer[1]).deliver_now
      rescue ErrorMessages::EmailError, ErrorMessages::RoleError, ErrorMessages::RequestTimeoutError => e
        flash[:error] = e.message
        redirect_to root_path
      rescue ErrorMessages::ImageError, ErrorMessages::AdminTimeoutError  => e
        SendAdminError.mail_create(current_user.email).deliver_now
        flash[:error] = e.message
        redirect_to root_path
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

  # def get_photos
  #   begin
  #     sleep_number = (1..6).to_a.sample
  #     random_number = (1..5000).to_a.sample
  #     if sleep_number > 3
  #       sleep(sleep_number)
  #       Rails.logger.debug "Response: #{sleep_number}"
  #       raise "Exception #: #{sleep_number}"
  #     else
  #       sleep(sleep_number)
  #       # Rails.logger.debug "Response img №2: #{sleep_number}"
  #       response = HTTParty.get("http://jsonplaceholder.typicode.com/photos/#{random_number}")
  #       image = JSON.parse(response.body)
  #       if image['url'][-6..-1].to_i(16)  > image['thumbnailUrl'][-6..-1].to_i(16)
  #         return image['url']
  #       else
  #         return 1
  #       end
  #     end
  #   rescue Exception=>e
  #     Rails.logger.error { "Encountered an error when trying get photos, #{e}" }
  #     return false
  #   end
  # end


  # def send_todos
  #   tries ||= 3
  #   begin
  #     sleep_number = (1..6).to_a.sample
  #     if sleep_number > 3
  #       sleep(sleep_number)
  #       Rails.logger.debug "Response send_todos: #{sleep_number}"
  #       raise "Exception #: #{sleep_number}"
  #     else
  #       sleep(sleep_number)
  #       response = HTTParty.post("http://jsonplaceholder.typicode.com/todos",
  #                                {
  #                                  :data => { title: 'foo', body: 'bar', userId: 1 }
  #                                }
  #                                )
  #       post = JSON.parse(response.body)
  #       post['id']
  #     end
  #   rescue Exception=>e
  #     Rails.logger.error { "Encountered an error when trying send todos, #{e}" }
  #     if (tries -= 1) > 0
  #       retry
  #     else
  #       return false
  #     end
  #   end
  # end
end
