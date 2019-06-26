class UsersMailer < ActionMailer::Base

  def welcome_email(email)

    @email = email
    RestClient.post "https://api:key-32671ce9b0a7a29c51aa9d8466cd40b1"\
	                  "@api.mailgun.net/v3/sandbox81f573c040064bdaad555c6175c7beb7.mailgun.org/messages",

                    :from => "Excited User <mailgun@sandbox81f573c040064bdaad555c6175c7beb7.mailgun.org>",
                    :to => @email,
                    :subject => "Hello",
                    :text => "Testing some Mailgun awesomness!"

    end
  end
