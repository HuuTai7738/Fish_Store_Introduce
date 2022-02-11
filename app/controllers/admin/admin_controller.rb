class Admin::AdminController < ApplicationController
  before_action :require_admin
  layout "admin"

  def index; end

  private
  def require_admin
    return if admin_signed_in

    redirect_to root_path
    flash[:danger] = t "login_admin"
  end
end
