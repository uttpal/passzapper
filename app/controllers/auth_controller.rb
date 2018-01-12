class AuthController < ApplicationController
  skip_before_action :authorize_request

  def register
    user = User.create!(auth_params)
    token = JsonWebToken.encode({id: user[:id]})
    json_response({token: token})
  end

  def login
    user = User.find_by(username: auth_params[:username])
    if user.password != auth_params[:password]
      raise(ExceptionHandler::UnAuthorized, 'Incorrect username or password')
    end
    token = JsonWebToken.encode({id: user[:id]})
    json_response({token: token})
  end

  def auth_params
    params.permit(:username, :password)
  end

end
