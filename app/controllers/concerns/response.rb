module Response
  def error_response(errors, status = :unprocessable_entity)
    render json: JSON.parse(errors.to_json).merge({ error_full_messages: errors.full_messages }), status:
  end

  def internal_server_error_response(errors, status = 500)
    render json: { errors: }, status:
  end

  def not_found_response(errors, status = :not_found)
    render json: errors, status:
  end

  def not_found_json_response(errors)
    render json: { errors: }, status: :not_found
  end

  def bad_request_response(errors)
    render json: { errors: }, status: :bad_request
  end

  def unprocessable_entity_response(errors)
    render json: errors, status: :unprocessable_entity
  end
end
