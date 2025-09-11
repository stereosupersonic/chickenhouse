class Admin::BaseController < ApplicationController
  before_action :require_admin!

  rate_limit to: 100, within: 1.hour, only: [ :index, :create, :update, :destroy ], with: -> { redirect_to admin_root_path, alert: "Too many requests. Please try again later." }

  def index; end

  private

  def require_admin!
    redirect_to root_path, alert: "Access denied. Admin privileges required." unless Current.user&.admin?
  end
end
