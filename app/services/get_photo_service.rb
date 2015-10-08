class GetPhotoService < PurchaseService
  include HTTParty
  base_uri "jsonplaceholder.typicode.com"
  def call
    get_photos
  end
  private
  def get_photos
    @sleep_number = (1..6).to_a.sample
    sleep(@sleep_number)
    Rails.logger.debug "Response: #{@sleep_number}"
    raise ErrorMessages::RequestTimeoutError if @sleep_number > 3
    photo_id = Random.new.rand(1..5000)
    response = self.class.get("/photos/#{photo_id}")
    if response.success?
      raise ErrorMessages::ImageError if hex_from_url(response['url']) < hex_from_url(response['thumbnailUrl'])
      response['url']
    else
      # this just raises the net/http response that was raised
      raise response.response
      Rails.logger.error { "Encountered an error when trying get photos, #{response}" }
    end
  end

  def hex_from_url(url)
    url[-6..-1].to_i(16)
  end
end
