class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'

  CONTACT_EMAIL = "horeapetrila@gmail.com"

  def welcome_mail
    mail(to: CONTACT_EMAIL, subject: 'HELLO!')

  end

end
