class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource
  def index
    @pagy, @category = pagy Category.all, items: Settings.item_per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "success"
      redirect_to admin_categories_url
    else
      flash[:danger] = t "create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "success"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.products.present?
      flash[:warning] = t "product_still_have"
    elsif @category.destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "fails"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
