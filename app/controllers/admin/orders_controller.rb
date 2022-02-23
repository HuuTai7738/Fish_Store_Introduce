class Admin::OrdersController < Admin::AdminController
  before_action :load_order, only: %i(update show)

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

  private
  def load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t "not_found"
    redirect_to admin_orders_path
  end
end
