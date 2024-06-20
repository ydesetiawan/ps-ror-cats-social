# frozen_string_literal: true
module AuthenticationHelper
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def generate_token(user_id)
    exp = 8.hours.from_now.to_i
    payload = { user_id: user_id, exp: exp }
    JWT.encode(payload, SECRET_KEY)
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

end
