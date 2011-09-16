class ApplicationController < ActionController::Base
    protect_from_forgery
    include SessionsHelper
    include TWExceptions
    around_filter :catch_exceptions

    private

    def catch_exceptions
        yield
    rescue TWNotAllowed => notAllowed
      logger.debug "TelemetryWeb says not allowed."
      redirect_to "/confirm"
    rescue TWSessionEnded => twSessEnded
      logger.debug "TelemetryWeb session ended."
      sign_out
      deny_access
    rescue Exception => e
        logger.debug "Caught exception! #{e}"
        raise
        end
end
