class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :error_response

  def error_response(error)
    error_member = ErrorMember.new(error.message, 400, "Bad Request")
    render json: ErrorMemberSerializer.new(error_member).serialized_json
  end
end
