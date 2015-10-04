class PostTodoService < PurchaseService
  include HTTParty
  base_uri "jsonplaceholder.typicode.com"
  def call
    send_todos
  end
  private
  def send_todos
    tries ||= 3
    begin
      @sleep_number = (1..6).to_a.sample
      sleep(@sleep_number)
      if @sleep_number > 3
        # retry if (tries -= 1) > 0
        Rails.logger.debug "Response send_todos: #{@sleep_number}"
        raise ErrorMessages::AdminTimeoutError
      else
        options = { query: {title: 'foo', body: 'bar', userId: 1 }}
        response = self.class.post('/todos', options)
        if response.success?
          response['id']
        else
          # this just raises the net/http response that was raised
          raise response.response
          Rails.logger.error { "Encountered an error when trying get photos, #{response}" }
        end
      end
    rescue ErrorMessages::AdminTimeoutError => e
      Rails.logger.error { "Encountered an error when trying send todos, #{e}" }
      if (tries -= 1) > 0
        retry
      end
    end
  end
end
