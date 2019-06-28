class JsonWebToken

  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)

    payload[:exp] = exp.to_i
    JWT.encode(payload, 'john e boss')
  end

  def self.decode(token)
    body = JWT.decode(token, 'john e boss')[0]
    HashWithIndifferentAccess.new body

  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message

  end

end