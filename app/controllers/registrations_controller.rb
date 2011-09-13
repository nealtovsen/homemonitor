class RegistrationsController < ApplicationController

    def new
        @title = "Sign up"
    end

    def create
        Registration.new.register(params[:registrations])

        flash[:success] = "Thank you for registering! Please check your email for further instructions."
        redirect_to root_path
        
        rescue TWRegFailed => twRegFailed
          logger.debug "Registration failed."
          if twRegFailed.reason.nil?
            flash.now[:error] = "Registration failed."
          else
            flash.now[:error] = "Registration failed." + twRegFailed.reason
          end
          render 'new'
        
    end

end