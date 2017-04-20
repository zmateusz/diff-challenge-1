class Api::V1::OrdersController < ApplicationController
  def index
    with_authorization do |current_user|
      orders = current_user.orders.order(created_at: :desc).includes(:founder).includes(:users).map(&:serialized_params)
      render json: { results: orders }
    end
  end

  def create
    with_authorization do |current_user|
      users = if order_params[:group_id].present?
        Group.find(order_params[:group_id]).users - [current_user]
      else
        User.where(email: order_params[:invited_users_emails])
      end

      order = Order.new(founder: current_user, restaurant: order_params[:restaurant])
      order.group_id = order_params[:group_id]
      order.users << users + [current_user]
      if order.save
        head :created
      else
        render json: { errors: order.errors }, status: :unprocessable_entity
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:group_id, :restaurant, invited_users_emails: [])
  end
end
