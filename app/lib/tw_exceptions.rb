module TWExceptions
  class TWSessionEnded < StandardError
    def message
      "Your session has ended. Please login again."
    end

  end

  class TWRegFailed < StandardError
    attr_accessor :reason
    def message
      "Registration Failed."
    end

  end
  
  class TWNotAllowed < StandardError
    def message
      "Access Denied."
    end

  end

end
