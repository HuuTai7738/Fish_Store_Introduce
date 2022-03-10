class Admin::OrdersController < Admin::AdminController
  load_and_authorize_resource

  def index
    @q = Order.joins(:user).ransack params[:q]
    @order = @q.result.newest
    @pagy, @order = pagy @order, items: Settings.item_per_page
  end

  def show; end

  def update
    if Order.statuses.include? params[:status]
      @order.public_send "#{params[:status]}!"
    else
      flash[:danger] = t "wrong_status"
    end
    redirect_to admin_orders_path
  end
end
