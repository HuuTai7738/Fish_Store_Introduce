class ApplicationController < ActionController::Base
  include Pagy::Backend
  include CartsHelper
  include OrdersHelper
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied, with: :access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def after_sign_in_path_for resource
    if resource.admin?
      admin_root_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::PROPERTIES
    devise_parameter_sanitizer.permit :account_update, keys: User::PROPERTIES
  end

  private

  def not_found
    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def access_denied
    flash[:danger] = t "not_permission"
    redirect_to root_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
