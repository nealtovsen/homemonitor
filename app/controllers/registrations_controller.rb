class RegistrationsController < ApplicationController

    def new
        @title = "Sign up"
    end

    def create
        puts "hello!! " + params[:registrations].to_s
        Registration.new.register(params[:registrations])
        render 'confirm'
    end

end