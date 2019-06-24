module ControllerSpecHelper
  def token_generator(user_p_id)
    JsonWebToken.encode(user_p_id: user_p_id)
  end

  def expired_token_generator(user_p_id)
    JsonWebToken.encode({ user_p_id: user_p_id }, (Time.now.to_i - 10))
  end

  # return valid headers
  def valid_headers
    {
        "Authorization" => token_generator(user_p.id),
        "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
        "Authorization" => nil,
        "Content-Type" => "application/json"
    }
  end

end