# app/services/registration_service.rb

module Users
  class RegistrationService
    include AuthenticationHelper

    def initialize(user_params)
      @user_params = user_params
    end

    def register
      check_email_uniqueness
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
      def check_email_uniqueness
        if User.exists?(email: @user_params[:email])
          raise ConflictException.new("Email has already been taken")
        end
      end
      def encrypt_password
        @user.password = BCrypt::Password.create(@user_params[:password])
      end
      def save_user
        if @user.save
          { message: "User registered successfully", data: response_data(@user) }
        else
          raise InternalServerErrorException.new(@user.errors.full_messages.join(", "))
        end
      end
  end
end
