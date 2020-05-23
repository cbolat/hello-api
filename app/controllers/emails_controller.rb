class EmailsController < ApplicationController
  skip_before_action :authorize_request, only: :create
  def create
    UserMailer.welcome_mail(email_params[:email]).deliver_now
  end

  private
  def email_params
    params.permit( :email)
  end

end
