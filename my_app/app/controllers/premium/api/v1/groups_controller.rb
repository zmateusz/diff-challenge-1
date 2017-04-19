class Premium::Api::V1::GroupsController < ApplicationController
  def index
    with_authorization do
      render json: { results: Group.all.order(created_at: :desc).includes(:users).map(&:serialized_params) }
    end
  end

  def create
    with_authorization do |current_user|
      if current_user.email.split('@')[1] == group_params[:domain]
        Group.find_or_create_by(domain: group_params[:domain])

        head :created
      else
        head :unprocessable_entity
      end
    end
  end

  def group_params
    params.require(:group).permit(:domain)
  end
end
