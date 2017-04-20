class Premium::Api::V1::OrdersController < ApplicationController
  def index
    with_authorization do |current_user|
      domain = current_user.email.split('@')[1]
      orders = Order.joins(:group).where(groups: { domain: domain })
                .includes(:founder)
                .includes(:users)
                .order(created_at: :desc)
      render json: { results: orders.map(&:serialized_params) }
    end
  end
end
