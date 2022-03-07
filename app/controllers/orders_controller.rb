class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.includes(:order_details).newest
    return if @orders

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def new
    @products_in_cart = {}

    current_carts.each do |id, quantity|
      product = load_product_in_cart id
      @products_in_cart[product] = quantity.to_i
    end
  end

  def create
    @order = current_user.orders.new order_params
    create_order_detail
    if @order.save
      handle_success_order
    else
      flash[:danger] = t "order_fails"
      redirect_to checkout_path
    end
  end

  def update
    order = Order.includes(:order_details).find_by id: params[:id]
    if order
      order.order_details.each do |detail|
        product = Product.find_by id: detail.product_id
        product.update_attribute(:quantity, product.quantity + detail.quantity)
      end
      order.canceled!
    else
      flash[:danger] = "fails"
      redirect_to list_orders_path
    end
  end

  private
  def order_params
    params.permit :user_id, :order_address, :order_date
  end

  def create_order_detail
    current_carts.each do |id, quantity|
      @product = Product.find_by id: id

      quantity = @product.quantity if quantity > @product.quantity
      @product.update_attribute(:quantity, @product.quantity - quantity)
      @order.order_details.build(
        quantity: quantity,
        price: @product.price,
        unit: @product.unit,
        product_id: @product.id
      )
    end
  end

  def handle_success_order
    current_carts.clear
    flash[:success] = t "success"
    redirect_to root_url
  end
end
