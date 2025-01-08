class Admin::BaseController < ApplicationController
  before_action :require_signin_as_admin!

  def index; end
end
