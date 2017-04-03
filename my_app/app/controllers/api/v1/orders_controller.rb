class Api::V1::OrdersController < ApplicationController
  def index
    with_authorization do
      render json: { results: Order.all.includes(:founder).includes(:users).map(&:serialized_params) }
    end
  end

  def create
    with_authorization do |current_user|
      order = Order.new(founder: current_user, restaurant: order_params[:restaurant])
      users = User.where(email: order_params[:invited_users_emails])
      order.users << users

      if order.save
        head :created
      else
        render json: { errors: order.errors }, status: :unprocessable_entity
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:restaurant, invited_users_emails: [])
  end
end
