class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate params[:session][:password]
      log_in user
      if admin_signed_in
        redirect_to admin_root_url
      else
        redirect_to root_url
      end
    else
      flash[:danger] = t "fail_login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
