class ConfirmationsController < ApplicationController
  before_filter :authenticate

  include SessionsHelper
  include ApplicationHelper

  def new
    @title = "Confirm your account"
  end

  def create
    Confirmation.new.confirm(params[:confirmations], @current_user)
    redirect_to root_path
  end

end