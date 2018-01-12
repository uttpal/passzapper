module ExceptionHandler
  extend ActiveSupport::Concern

  class InvalidToken < StandardError; end
  class MissingToken < StandardError; end
  class UnAuthorized < StandardError; end
  class InvalidInput < StandardError; end


  included do
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::UnAuthorized, with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidInput, with: :four_twenty_two
  end


  def unauthorized_request(e)
    json_response({message: e.message}, :unauthorized)
  end

  def four_twenty_two(e)
    json_response({message: e.message}, :unprocessable_entity)
  end
end
