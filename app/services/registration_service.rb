# app/services/registration_service.rb
class RegistrationService
  SECRET_KEY = "KEY"
  def initialize(user_params)
    @user_params = user_params
  end

  def register
    validate_password_length

    @user = User.new(@user_params)

    if @user.valid?
      encrypt_password
      save_user
    else
      raise BadRequestException.new(@user.errors.full_messages.join(", "))
    end
  end

  private
    def validate_password_length
      password = @user_params[:password]
      raise BadRequestException.new("Password to long (>15)") if password.length > 15
    end

    def encrypt_password
      @user.password = BCrypt::Password.create(@user_params[:password])
    end

    def save_user
      if @user.save
        { message: "User registered successfully", data: response_data }
      else
        raise InternalServerErrorException.new(@user.errors.full_messages.join(", "))
      end
    end
    def response_data
      {
        email: @user.email,
        name: @user.name,
        accessToken: generate_token
      }
    end
    def generate_token
      exp = 8.hours.from_now.to_i
      payload = { user_id: @user.id, exp: }
      JWT.encode(payload, SECRET_KEY)
    end
end
