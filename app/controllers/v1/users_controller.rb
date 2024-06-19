module V1
  class UsersController < ::ApplicationController
    skip_before_action :verify_authenticity_token, only: [:register]
    def register
      @user = User.new(user_params)
      if @user.valid?
        @user.password = BCrypt::Password.create(user_params[:password])
        if @user.save
          data = { message: "Data saved" }
        else
          err = @user.errors.full_messages
          data = { message: "Data failed" , error: err}
        end

        render json: data
      else
        err = @user.errors.full_messages
        render json: err
      end
    end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
  end
end
