class PassController < ApplicationController

  skip_before_action :authorize_request, only: :show

  def create
    enc_pass = Crypto.encrypt(create_pass_params[:pass], current_user[:username])
    pass = Pass.create!({
                          pass: enc_pass,
                          key: SecureRandom.hex(10)
                        })
    json_response({key: pass[:key]})
  end

  def show
    pass_key = request.path_parameters[:id]
    user_initial = request.query_parameters[:username]
    pass = Pass.find_by(key: pass_key)
    decrypted = Crypto.decrypt(pass[:pass], user_initial)
    json_response({pass: decrypted})
  rescue Exception => e
      raise(ExceptionHandler::InvalidInput, 'Invalid key or username')
  end

  def create_pass_params
    params.permit(:pass)
  end

end
