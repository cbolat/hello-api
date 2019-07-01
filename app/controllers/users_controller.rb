# app/controllers/users_controller.rb
class UsersController < ApplicationController
  # POST /signup
  # return authenticated token upon signup
  skip_before_action :authorize_request, only: :create
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
    # ExampleMailer.send_simple_message(user).perform_async
    # SendEmailJob.set(wait: 20.seconds).perform_later(@user)
   # ExampleMailer.send_simple_message.deliver_now
    @user = User.new(user_params)

   # respond_to do |format|
   #
   #      # Sends email to user when user is created.
   #     ExampleMailer.send_simple_message.deliver_later
   #     if
   #     format.html { redirect_to @user, notice: 'User was successfully created.' } and return
   #     format.json { render :show, status: :created, location: @user } and return
   #     end
   #   else
   #     format.html { render :new } and return
   #     format.json { render json: @user.errors, status: :unprocessable_entity } and return
   #   end


    end


  private

  def user_params
    params.permit(
        :name,
        :email,
        :password,
        :password_confirmation
    )
  end
end





