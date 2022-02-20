module Admin::ProductsHelper
  def status_color status
    case status.to_sym
    when :activated
      :success
    when :deactivated
      :danger
    end
  end

  def load_category_select
    Category.select(:id, :name)
  end
end
