module OrdersHelper
  def total_order order
    order.order_details.sum("price * quantity")
  end

  def check_status order
    order.new_order?
  end
end
