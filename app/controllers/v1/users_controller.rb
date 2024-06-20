# Generic resource bad request exception
module V1
  class UsersController < ::ApplicationController
    skip_before_action :verify_authenticity_token
    def register
      service = RegistrationService.new(user_params)
      result = service.register
      render json: result
    end
    def login
      service = LoginService.new(login_params)
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
