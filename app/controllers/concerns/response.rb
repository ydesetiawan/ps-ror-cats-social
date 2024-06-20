module Response

  def internal_server_error_response(errors, status = 500)
    render json: { errors: }, status:
  end

  def conflict_response(errors, status = 409)
    render json: { errors: }, status:
  end

  def unauthorized_response(errors, status = 401)
    render json: { errors: }, status:
  end


  def not_found_response(errors, status = :not_found)
    render json: { errors: }, status:
  end


  def bad_request_response(errors)
    render json: { errors: }, status: :bad_request
  end

end
