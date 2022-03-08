class Admin::AdminController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  layout "admin"

  private
  def is_admin?
    return if current_user.admin?

    flash[:danger] = t "login_admin"
    redirect_to root_path
  end
end
