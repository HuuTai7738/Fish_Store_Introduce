class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false
  layout "admin"
end
