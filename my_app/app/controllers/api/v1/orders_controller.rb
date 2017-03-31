class Api::V1::OrdersController < ApplicationController
  def index
    with_authorization do
      render json: {}, status: :ok
    end
  end
end
