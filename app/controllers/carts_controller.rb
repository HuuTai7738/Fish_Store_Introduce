class CartsController < ApplicationController
  before_action :load_product_with_quantity, only: %i(create update)
  def index
    @products_in_cart = {}

    current_carts.each do |id, quantity|
      product = load_product_in_cart id
      @products_in_cart[product] = quantity.to_i
    end
  end

  def create
    if @quantity.positive? && @quantity < @product.quantity
      add_to_cart params[:id], params[:quantity]
      flash[:success] = t "success"
    else
      flash[:warning] = t "fails"
    end
    redirect_to carts_path
  end

  def update
    update_quantity_cart params[:id], params[:quantity]
    respond_to do |format|
      format.js
    end
  end

  def destroy
    delete_item_cart params[:id]
    redirect_to carts_path
  end

  private
  def add_to_cart id, quantity
    current_carts[id] = if current_carts.key?(id)
                          current_carts[id] + quantity.to_i
                        else
                          quantity.to_i
                        end
  end

  def update_quantity_cart id, quantity
    current_carts[id] =
      current_carts.key?(id) ? quantity.to_i : Settings.quantity
  end

  def load_product_with_quantity
    @product = Product.find_by id: params[:id]
    @quantity = params[:quantity].to_i
    return if @product && @quantity

    flash[:danger] = t "not_found"
    redirect_to carts_path
  end
end
