# frozen_string_literal: true

module AuthenticationHelper
  extend ActiveSupport::Concern
  include Response
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def generate_token(user_id)
    exp = 8.hours.from_now.to_i
    payload = { user_id:, exp: }
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  rescue JWT::DecodeError => e
    e
  end

  def response_data(user)
    {
      email: user.email,
      name: user.name,
      accessToken: generate_token(user.id)
    }
  end

  def check_password(user, password)
    BCrypt::Password.new(user.password) == password
  end

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    return unauthorized_response('Unauthorized') unless token

    begin
      decoded_token = decode_token(token)
      return unauthorized_response('Unauthorized')  unless decoded_token

      @current_user = User.find_by(id: decoded_token[:user_id])
      render unauthorized_response('Unauthorized')  unless @current_user
    rescue StandardError => e
      unauthorized_response(e)
    end
  end

  def current_user
    @current_user
  end
end
