class SendmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserMailer.welcome_mail
  end
end
