module ControllerSpecHelper
  def token_generator(userb_id)
    JsonWebToken.encode(userb_id: userb_id)
  end

  def expired_token_generator(userb_id)
    JsonWebToken.encode({ userb_id: userb_id }, (Time.now.to_i - 10))
  end


  def valid_headers
    {
        "Authorization" => token_generator(userb.id),
        "Content-Type" => "application/json"
    }
  end


  def invalid_headers
    {
        "Authorization" => nil,
        "Content-Type" => "application/json"
    }
  end

end