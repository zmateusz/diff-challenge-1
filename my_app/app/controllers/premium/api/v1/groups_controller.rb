class Premium::Api::V1::GroupsController < ApplicationController
  def index
    with_authorization do
      render json: { results: Group.all.order(created_at: :desc).includes(:users).map(&:serialized_params) }
    end
  end

  def create
    with_authorization do |current_user|
      Group.find_or_create_by(domain: group_params[:domain])

      head :created
    end
  end

  def group_params
    params.require(:group).permit(:domain)
  end
end
