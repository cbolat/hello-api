class UsersMailer < ActionMailer::Base

  def welcome_email(user_id)
    @user = Userb.find(user_id)


    RestClient.post "https://api:61bbd338fe4d8731bf7975edf027b1e2-2b778fc3-b7d57bbd"\
                    "@api.mailgun.net/v3/sandbox81f573c040064bdaad555c6175c7beb7.mailgun.org/messages",

                    :from    => "Excited User <mailgun@sandbox81f573c040064bdaad555c6175c7beb7.mailgun.org>",
                    :to      => @user.email,
                    :subject => "Welcome",
                    :text    => "Testing testing"

    end
  end
