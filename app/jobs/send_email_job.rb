class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    @user = user
    ExampleMailer.send_simple_message(@user).deliver_later
  end
end