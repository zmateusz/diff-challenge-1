class Order < ApplicationRecord
  belongs_to :founder, class_name: 'User', foreign_key: 'user_id'
  belongs_to :group, optional: true

  has_many :order_invitations, dependent: :destroy
  has_many :users, -> { order "email ASC" }, through: :order_invitations

  def serialized_params
    {
      founder: { email: founder.email },
      restaurant: restaurant
    }.tap do |hash|
      hash[:domain] = group.domain if group&.domain
      hash[:invited_users] = users.map { |user| { email: user.email } } unless group&.domain
    end
  end
end
