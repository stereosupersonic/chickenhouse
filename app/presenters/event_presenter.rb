class EventPresenter < ApplicationPresenter
  def html_content
    simple_format(sanitize(o.content))
  end

  def formatted_start_date
    return "" if o.start_date.blank?

   format_datetime(o.start_date)
  end

  def formatted_end_date
    return "" if o.end_date.blank?

    format_datetime(o.end_date)
  end

  private

  def format_datetime(val)
    if o.all_day?
      I18n.l(val, format: :day)
    else
      I18n.l(val, format: :default)
    end
  end
end
