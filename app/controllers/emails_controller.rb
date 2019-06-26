class EmailsController < ApplicationController
  def create
    UserMailer.welcome_email(email_params[:email_address]).perform_async
  end

  private
  def email_params
    params.permit(:email_address)
  end
end
