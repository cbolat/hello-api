class AuthenticateUser
  def initialize(email,password)
    @email=email
    @password=password
  end

  def call
    JsonWebToken.encode(user_p_id: user_p.id) if user_p
  end

  private
  attr_reader :email, :password

  def user_p
    user_p= UserP.find_by(email: email)
    return user_p if user_p
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end

end