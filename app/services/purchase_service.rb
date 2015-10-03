class PurchaseError < StandardError
end

class RequestTimeoutError < TimeoutError
end

class PurchaseService
  include HTTParty

  base_uri "jsonplaceholder.typicode.com"
  sleep_number = (1..6).to_a.sample
end
