class User < ApplicationRecord
  has_secure_password

  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_many :order_invitations, dependent: :destroy
  has_many :orders, through: :order_invitations

  has_many :founded_orders, class_name: 'Order', foreign_key: 'user_id'

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def generate_access_token
    token = SecureRandom.hex
    while User.find_by(access_token: token)
      token = SecureRandom.hex
    end

    update(access_token: token)
  end

  def serialized_params
    {
      id: id,
      email: email,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
