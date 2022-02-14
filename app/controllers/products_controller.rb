class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @pagy, @products = pagy Product.activated_products,
                            items: Settings.item_per_page
  end

  def show
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
