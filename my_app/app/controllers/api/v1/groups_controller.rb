class Api::V1::GroupsController < ApplicationController
  def create
    with_authorization do |current_user|
      emails = group_params[:emails]
      users = [current_user]
      emails.each do |email|
        user = User.find_by(email: email)
        users << user if user
      end

      group = Group.create
      users.each { |user| GroupMembership.create(group: group, user: user) }

      head: :created
    end
  end

  private

  def group_params
    params.require(:group).permit(emails: [])
  end
end
