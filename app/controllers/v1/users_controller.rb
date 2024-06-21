module V1
  class UsersController < ::ApplicationController
    def register
      service = Users::RegistrationService.new(user_params)
      result = service.register
      render json: result
    end
    def login
      service = Users::LoginService.new(login_params)
      result = service.login
      render json: result
    end

    private
      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
      def login_params
        params.require(:user).permit(:email, :password)
      end
  end
end