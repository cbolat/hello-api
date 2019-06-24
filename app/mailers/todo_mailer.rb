class TodoMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def welcome_email

    mail to: "horeapetrila@gmail.com", subject: "New mail"


  end
end

