class Api::V1::UsersController < ApplicationController
  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    new_user.save!
    ApiKey.create!(user_id: new_user.id, access_token: SecureRandom.hex)
    render json: UserSerializer.new(new_user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end