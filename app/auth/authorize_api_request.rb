class AuthorizeApiRequest

  def initialize(headers = {})
    @headers = headers
  end
  def call
    user = get_user
    return user
  end

  attr_reader :headers

  private

  def get_user
    token = http_auth_token
    userId = decode_auth_token(token)['id']
    User.find(userId)
  end

  def decode_auth_token(token)
    user = JsonWebToken.decode(token)[0]
  end

  def http_auth_token
    if headers[:Authorization].present?
      return headers[:Authorization].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, 'Missing Token')
  end
end
