class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource
  def index
    @q = User.ransack params[:q]
    @user = @q.result.newest
    @pagy, @user = pagy @user, items: Settings.item_per_page
  end
end
