class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(userb_id: userb.id) if userb
  end

  private

  attr_reader :email, :password

  def userb
    userb = Userb.find_by(email: email)
    return userb if userb

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end

