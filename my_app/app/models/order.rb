class Order < ApplicationRecord
  belongs_to :founder, class_name: 'User', foreign_key: 'user_id'

  def serialized_params
    {
      founder: { email: founder.email },
      restaurant: restaurant
    }
  end
end
