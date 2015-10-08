module ErrorMessages
  class EmailError < StandardError
    def message
      "Users can not buy products if they have email in the zone com"
    end
  end

  class ImageError < StandardError
    def message
      "Unfortunately it was not possible to make a purchase now. Try again later"
    end
  end

  class RequestTimeoutError < TimeoutError
    def message
      "Encountered an error when trying get photos"
    end
  end
  class AdminTimeoutError < TimeoutError
    def message
      "Encountered an error when trying send todos"
    end
  end
end
