class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @pagy, @products = pagy Product.activated_products,
                            items: Settings.item_per_page
  end
end
