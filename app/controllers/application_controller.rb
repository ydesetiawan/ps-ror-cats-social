class ApplicationController < ActionController::Base
  include Response

  rescue_from BadRequestException, with: :bad_request_response
  rescue_from InternalServerErrorException, with: :internal_server_error_response
end
