class TodoSendMail
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    # @user = params[:user]
    #mail(to: @user.email, subject: 'WELCOME!')
  end

end