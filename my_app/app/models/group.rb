class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  def serialized_params
    {
      id: id,
      users: users.map { |user| { email: user.email } }
    }
  end
end
