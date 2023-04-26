class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else  
      error_member = ErrorMember.new("Your username or password is incorrect", 400, "Bad Request")
      render json: ErrorMemberSerializer.new(error_member).serialized_json
    end 
  end
end