# Generic resource bad request exception
module V1
  class UsersController < ::ApplicationController
    skip_before_action :verify_authenticity_token, only: [:register]
    def register
      service = RegistrationService.new(user_params)
      result = service.register
      render json: result
    end

    private
      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
  end
end
