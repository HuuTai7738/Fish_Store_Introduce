class Admin::ProductsController < Admin::AdminController
  include Admin::ProductsHelper
  load_and_authorize_resource

  def index
    @q = Product.ransack params[:q]
    @product = @q.result.newest
    @pagy, @product = pagy @product, items: Settings.item_per_page
  end

  def new
    @product = Product.new
  end

  def show; end

  def edit; end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "success"
      redirect_to admin_products_url
    else
      flash[:danger] = t "create_fail"
      render :new
    end
  end

  def update
    if @product.update product_params
      if params[:product][:status] == "deactivated"
        handle_product_exist_in_order
      end
      flash[:success] = t "success"
      redirect_to admin_products_url
    else
      flash[:danger] = t "fails"
      render :edit
    end
  end

  def destroy
    handle_product_exist_in_order
    @product.deactivated!
    flash[:success] = t "success"
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit(:name,
                                    :description,
                                    :status,
                                    :price,
                                    :unit,
                                    :quantity,
                                    :category_id,
                                    :image)
  end

  def handle_product_exist_in_order
    order_details = Order.success_order_with_pro_id(@product.id)
    order_details.each(&:rejected!)
  end
end
