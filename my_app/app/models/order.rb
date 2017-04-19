class Order < ApplicationRecord
  belongs_to :founder, class_name: 'User', foreign_key: 'user_id'

  has_many :order_invitations, dependent: :destroy
  has_many :users, -> { order "email ASC" }, through: :order_invitations

  def serialized_params
    {
      founder: { email: founder.email },
      invited_users: users.map { |user| { email: user.email } },
      restaurant: restaurant
    }
  end
end
