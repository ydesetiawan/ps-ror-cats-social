class V1::UsersController < ApplicationController
  def register
    def user_params
      params.require(:user).permit(:email, :name, :password)
    end

    user = User.new(user_params)

    if user.save
      token = generate_token(user)
      render json: {
        message: "User registered successfully",
        data: {
          email: user.email,
          name: user.name,
          accessToken: token
        }
      }, status: :created
    else
      if User.exists?(email: user.email)
        render json: { error: "Email already exists" }, status: :conflict
      else
        render json: { errors: user.errors.full_messages }, status: :bad_request
      end
    end
  rescue => e
    render json: { error: "Internal server error" }, status: :internal_server_error
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password)
  end

  def generate_token(user)
    # Use your preferred method to generate a token
    # Here is an example using JWT
    expiration = 8.hours.from_now.to_i
    payload = { user_id: user.id, exp: expiration }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

end
