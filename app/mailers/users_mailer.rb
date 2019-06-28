require 'rest-client'

class UsersMailer < ActionMailer::Base

  def welcome_email
   # @user = User.find(user_id)
    RestClient.post "https://api:0da647417901d23c396db6cc0e0d7ccb-2b778fc3-d86d16aa"\
	  "@api.mailgun.net/v3/sandboxef12d244ad564b85ad90642d707caed1.mailgun.org/messages",
                    :from => "Excited User <mailgun@sandboxef12d244ad564b85ad90642d707caed1.mailgun.org>",
                    :to => "alin.budes@unifiedpost.com",
        :subject => "Hello time is: #{Time.now.to_s}",
        :text => "Testing some Mailgun awesomness!"
  end
end
