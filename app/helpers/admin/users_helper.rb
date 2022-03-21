module Admin::UsersHelper
  def count_order user
    user.orders.count
  end
end
