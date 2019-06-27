class UserMailer < ApplicationMailer

  #default from: "helloapi@example.com"
  def welcome_email(email)
    @email=email
    #missing lines
    #:to => @email,
    #    :subject => "Welcome to Hello API",
    #    :text => "Forever testing ....!"
  end
end
