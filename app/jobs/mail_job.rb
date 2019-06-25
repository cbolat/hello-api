class MailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TodoMailer.welcome_email.deliver_now

  end
end
