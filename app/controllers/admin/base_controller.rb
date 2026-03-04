class Admin::BaseController < ApplicationController
  before_action :require_admin!

  def index; end

  private

  def require_admin!
    redirect_to root_path, alert: "Access denied. Admin privileges required." unless Current.user&.admin?
  end
end
