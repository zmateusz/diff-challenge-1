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
    user = User.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        user.generate_access_token
        render json: { access_token: user.access_token }
      else
        render json: { error: 'Wrong password' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Wrong email' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
