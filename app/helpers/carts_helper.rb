module CartsHelper
  def current_carts
    session[:carts] ||= {}
  end

  def price_item_cart price, quantity
    quantity * price
  end

  def total_money_cart
    total = 0
    current_carts.each do |id, quantity|
      product = load_product_in_cart id
      total_item = price_item_cart product.price, quantity.to_i
      total += total_item
    end
    total
  end

  def load_product_in_cart id
    product = Product.find_by(id: id)
    return product if product.present?

    flash[:danger] = t "not_found"
    delete_item_cart id
  end

  def delete_item_cart id
    return unless current_carts.key?(id)

    current_carts.delete(id)
  end
end
