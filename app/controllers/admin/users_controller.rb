class Admin::UsersController < Admin::AdminController
  def index
    @user = User.search_by_name(params[:name]).newest
    @pagy, @user = pagy @user, items: Settings.item_per_page
  end
end
