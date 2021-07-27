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

  def current_role
    if current_user
      admin? ? "admin" : "user"
    else
      "anonymous"
    end
  end
  helper_method :current_role

  def require_signin_as_admin!
    redirect_to root_path, alert: "You are not an admin. GO AWAY!!!" unless admin?
  end
  helper_method :require_signin_as_admin!

  protected

  def convert_array_to_csv(data)
    csv_value = ""
    require "csv"
    csv = CSV.new(csv_value, force_quotes: true, col_sep: ";", row_sep: "\n")
    data.each do |value|
      csv << value.map do |v|
        v.to_s
      rescue => error
        raise "Error in iconv with value: #{value}: " + error.message
      end
    end
    csv_value
  end

  def send_as_csv(data, filename = "output.csv")
    send_data convert_array_to_csv(data),
      type: "text/csv; charset=utf-8; header=present",
      filename: filename
  end
end
