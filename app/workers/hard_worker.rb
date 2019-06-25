class HardWorker
  include Sidekiq::Worker

  def perform
    TodoMailer.welcome_email.deliver_now
  end
end
