class ApplicationController < ActionController::Base
  include Response
  include AuthenticationHelper

  rescue_from BadRequestException, with: :bad_request_response
  rescue_from InternalServerErrorException, with: :internal_server_error_response
  rescue_from ConflictException, with: :conflict_response
  rescue_from UnauthorizedException, with: :unauthorized_response
  rescue_from NotFoundException, with: :not_found_response

  skip_before_action :verify_authenticity_token
end
