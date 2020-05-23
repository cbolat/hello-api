class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    UserMailer.welcome_mail
  end
end
