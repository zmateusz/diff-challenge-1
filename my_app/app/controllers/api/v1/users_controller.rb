class Api::V1::UsersController < ApplicationController
  def sign_up
    user = User.new(user_params)

    if user.save
      render json: { user: user.serialized_params }, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def sign_in
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
