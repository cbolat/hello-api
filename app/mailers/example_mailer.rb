class ExampleMailer < ActionMailer::Base
  default from: "from@example.com"


def send_simple_message(user)
  @user=user
  RestClient.post "https://api:cdd05f106b39742401c10125a9754252-2b778fc3-a685e7fe"\
	"@api.mailgun.net/v3/sandbox435eb463a3ac4e2a94000e175feb7202.mailgun.org/messages",
                  :from => "Excited User <mailgun@sandbox435eb463a3ac4e2a94000e175feb7202.mailgun.org>",
  :to => @user.email,
      :subject => "Maine",
      :text => "Poimaine!"
end
end