require 'rest-client'

class EmailsController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    UsersMailer.welcome_email(email_params[:email_address]).deliver_later

  end

  private
  def email_params
    params.permit( :email_address )
  end
end