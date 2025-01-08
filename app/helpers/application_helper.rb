module ApplicationHelper
  def admin?
    # TODO
    false
  end

  def current_user
    # TODO
  end

  def current_role
    # TODO
  end

  def format_time(time)
    time&.strftime "%H:%M"
  end

  def format_date(date)
    date&.strftime "%d.%m.%Y"
  end

  def format_datetime(date)
    date&.strftime "%d.%m.%Y %H:%M"
  end
end
