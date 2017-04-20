class Api::V1::Premium::OrdersController < Api::V1::OrdersController
  private

  def orders_base(current_user)
    domain = current_user.email.split('@')[1]
    Order.joins(:group).where(groups: { domain: domain })
  end
end
