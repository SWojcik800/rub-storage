class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    token = request.headers["Authorization"]
    if token.present?
      decoded_token = decode_token(token)
      @current_user = User.find(decoded_token[:user_id])
    end

    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def decode_token(token)
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: "HS256")
      decoded.first.symbolize_keys
    rescue
      nil
    end
  end
end
