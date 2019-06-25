class UserbsController < ApplicationController
  skip_before_action :authorize_request, only: :create
  def create
    user=Userb.create!(user_params)
    auth_token=AuthenticateUser.new(user.email,user.password).call
    response={ message: Message.account_created, auth_token: auth_token}
    json_response(response, :created)
    mail = UsersMailer.welcome_email(user.id)
    mail.perform_async

  end

  private
  def user_params
    params.permit(
        :name,
        :email,
        :password

    )
  end

end
