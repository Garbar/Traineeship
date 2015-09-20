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
    message = ''
    title = 'Access is denied'
    error = 'Only registered users can make purchases'
    if @product.name_shop.blank? && @product.pro?
      title = 'Error!'
      message = 'This product is not for sale, apologize'
    else
      if current_user.allow_product?
        title = 'Error!'
        message = 'Only users with role \'User\' can make purchases'
      else
        if current_user.allow_email?
          if get_photos == 1
            title = 'Sorry!'
            message = 'Unfortunately it was not possible to make a purchase now. Try again later'
            SendAdminError.mail_create(current_user.email).deliver_now
          elsif get_photos == false
            title = 'Exception!'
            message = 'Encountered an error when trying get photos'
          else
            if send_todos == false
              title = 'Exception!'
              message = 'Encountered an error when trying send todos'
              SendAdminError.mail_create(current_user.email).deliver_now
            else
              title = 'Hello, user'
              message = 'Thank you for shopping in our store'
              SendUser.mail_create(get_photos, current_user.email).deliver_now
              SendAdmin.mail_create(send_todos).deliver_now
            end
          end
        else
          title = 'Error!'
          message = 'Users can not buy products if they have email in the zone com'
        end
      end
    end

    respond_to do |format|
      format.json { render json: {status: "ok", mess: message, title: title, error: error}}
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

  def get_photos
    begin
      sleep_number = (1..6).to_a.sample
      random_number = (1..5000).to_a.sample
      if sleep_number > 3
        sleep(sleep_number)
        Rails.logger.debug "Response: #{sleep_number}"
        raise "Exception #: #{sleep_number}"
      else
        sleep(sleep_number)
        # Rails.logger.debug "Response img №2: #{sleep_number}"
        response = HTTParty.get("http://jsonplaceholder.typicode.com/photos/#{random_number}")
        image = JSON.parse(response.body)
        if image['url'][-6..-1].to_i(16)  > image['thumbnailUrl'][-6..-1].to_i(16)
          return image['url']
        else
          return 1
        end
      end
    rescue Exception=>e
      Rails.logger.error { "Encountered an error when trying get photos, #{e}" }
      return false
    end
  end


  def send_todos
    tries ||= 3
    begin
      sleep_number = (1..6).to_a.sample
      if sleep_number > 3
        sleep(sleep_number)
        Rails.logger.debug "Response send_todos: #{sleep_number}"
        raise "Exception #: #{sleep_number}"
      else
        sleep(sleep_number)
        response = HTTParty.post("http://jsonplaceholder.typicode.com/todos",
                                 {
                                   :data => { title: 'foo', body: 'bar', userId: 1 }
                                 }
                                 )
        post = JSON.parse(response.body)
        post['id']
      end
    rescue Exception=>e
      Rails.logger.error { "Encountered an error when trying send todos, #{e}" }
      if (tries -= 1) > 0
        retry
      else
        return false
      end
    end
  end
end
