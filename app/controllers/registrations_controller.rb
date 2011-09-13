class RegistrationsController < ApplicationController

    def new
        @title = "Sign up"
    end

    def create
        Registration.new.register(params[:registrations])
        redirect_to "/confirm" #:controller => 'confirmations', :action => 'new'
    end

end