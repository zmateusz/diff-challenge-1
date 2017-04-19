class Api::V1::GroupsController < ApplicationController
  def index
    with_authorization do
      render json: { results: Group.all.order(created_at: :desc).includes(:users).map(&:serialized_params) }
    end
  end

  def create
    head :unprocessable_entity and return if params[:group][:domain]

    with_authorization do |current_user|
      emails = group_params[:emails]
      users = [current_user]
      emails.each do |email|
        user = User.find_by(email: email)
        users << user if user
      end

      group = Group.create
      users.each { |user| GroupMembership.create(group: group, user: user) }

      head :created
    end
  end

  private

  def group_params
    params.require(:group).permit(emails: [])
  end
end
