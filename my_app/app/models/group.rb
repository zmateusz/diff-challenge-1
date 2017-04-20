class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, -> { order "email ASC" }, through: :group_memberships
  has_many :orders, dependent: :destroy

  def serialized_params
    {
      id: id,
      users: users.present? ? users.map { |user| { email: user.email } } : nil,
      domain: domain
    }
  end
end
