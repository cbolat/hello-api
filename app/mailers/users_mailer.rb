class UsersMailer < ActionMailer::Base

  def welcome_email(email)

    @email = email


                    :from => "Excited User <mailgun@sandbox81f573c040064bdaad555c6175c7beb7.mailgun.org>",
                    :to => @email,
                    :subject => "Hello",
                    :text => "Testing some Mailgun awesomness!"

    end
  end
