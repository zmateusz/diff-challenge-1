class Order < ApplicationRecord
  belongs_to :founder, class_name: 'User', foreign_key: 'user_id'

  has_many :order_invitations, dependent: :destroy
  has_many :users, through: :order_invitations

  def serialized_params
    founder_params = { email: founder.email }
    {
      founder: founder_params,
      restaurant: restaurant,
      invited_users: users.map { |user| { email: user.email } } << founder_params
    }
  end
end
