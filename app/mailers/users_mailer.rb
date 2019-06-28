class UsersMailer < ActionMailer::Base

  def welcome_email(email)

    @email = email
    RestClient.post ""\"",

                    :from => "Sefu la bani <mailgun@sandboxc0ad8be77da3401f88e974c481120bb6.mailgun.org>",
                    :to => @email,
                    :subject => "TESTING",
                    :text => "IS THIS AN EMAIL?"

    end
  end
