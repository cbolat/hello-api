class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'


  def welcome_mail(email)
    @email = email
    mail(to: @email, subject: "TESTING!", text: 'testing the mailer')

  end

end
