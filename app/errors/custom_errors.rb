module CustomErrors
  class BaseError < StandardError
    attr_reader :message, :status

    def initialize(message, status: 500, detail: nil)
      super(message)
      @status = status
      @detail = detail
    end
  end

  class AuthenticationError < BaseError
    def initialize(message = 'Unauthorized', detail = nil)
      super(message, status: 401, detail: detail)
    end
  end

  class AuthorizationError < BaseError
    def initialize(message = 'Forbidden', detail = nil)
      super(message, status: 403, detail: detail)
    end
  end

  class RecordInvalidError < BaseError
    def initialize(message = 'Record Invalid', detail = nil)
      super(message, status: 404, detail: detail)
    end
  end

end