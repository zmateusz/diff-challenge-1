class User < ApplicationRecord
  has_secure_password

  validates :access_token, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def generate_access_token
    token = rand(0..100)
    while User.find_by(access_token: token)
      token = rand(0..100)
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
