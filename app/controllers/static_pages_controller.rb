class StaticPagesController < ApplicationController
  def home
    @products = Product.feature_products.activated_products
    @categories = Category.all
  end

  def contact; end
end
