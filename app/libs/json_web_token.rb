class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload)
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    JWT.decode(token, HMAC_SECRET)
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
