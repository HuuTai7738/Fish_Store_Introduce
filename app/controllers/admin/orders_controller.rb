class Admin::OrdersController < Admin::AdminController
  load_and_authorize_resource

  def index
    @order = Order.search_by_status(params[:status]).newest
    @pagy, @order = pagy @order, items: Settings.item_per_page
    return if params[:date].blank?

    @order = @order.filter_by_date(params[:date][:start], params[:date][:end])
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
