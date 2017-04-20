class Api::V1::Premium::GroupsController < Api::V1::GroupsController
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

  private

  def group_params
    params.require(:group).permit(:domain)
  end
end
