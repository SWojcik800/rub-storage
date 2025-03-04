class Api::V1::AuthController < ApplicationController
  require "jwt"

  SECRET_KEY = Rails.application.secret_key_base
  skip_before_action :authenticate_user, only: [ :login ]


  def login
    user = User.find_by(email: login_params[:email])
    puts params[:password]
    if user&.authenticate(params[:password])
      token = encode_token(user)
      render json: { token: token }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def encode_token(user)
    JWT.encode({ user_id: user.id }, SECRET_KEY, "HS256")
  end

  def login_params
    params.permit(:email, :password)
  end
end
