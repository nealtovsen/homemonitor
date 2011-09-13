class ConfirmationsController < ApplicationController
  def new
    @title = "Confirm your account"
  end

  def create
    Confirmation.new.confirm(params[:confirmations])
    redirect_to root_path
  end

end