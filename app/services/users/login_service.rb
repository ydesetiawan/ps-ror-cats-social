# frozen_string_literal: true

module Users
  class LoginService
    include AuthenticationHelper

    def initialize(login_params)
      @user = User.find_by_email(login_params[:email])
      @password = login_params[:password]
    end

    def login
      if @user && check_password(@user, @password)
        { message: "Login successful", data: response_data(@user) }
      else
        raise NotFoundException.new("Invalid email or password")
      end
    end
  end
end
