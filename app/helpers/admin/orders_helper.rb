module Admin::OrdersHelper
  def status_color_admin status
    case status.to_sym
    when :new_order
      :danger
    when :accepted
      :info
    when :rejected
      :info
    when :canceled
      :warning
    when :success
      :success
    end
  end

  def total_order order
    order.order_details.sum("price * quantity")
  end
end
