class ApplicationController < ActionController::Base
  protect_from_forgery

  # require sign in
  def require_signin!
    if current_user.nil?
      redirect_to login_url, alert: "You need to sign in first"
    end
  end
  helper_method :require_signin!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def admin?
    current_user.try(:admin?)
  end
  helper_method :admin?

  def require_signin_as_admin!
    redirect_to root_path, alert: "You are not an admin. GO AWAY!!!"    unless admin?
  end
  helper_method :require_signin_as_admin!
end
