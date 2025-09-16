class EventPresenter < ApplicationPresenter
  def html_content
    simple_format(sanitize(o.content))
  end

  def formatted_start_date
    return "" if o.start_date.blank?

    if o.all_day?
      I18n.localize(o.start_date, format: :day)
    else
      I18n.localize(o.start_date, format: :short)
    end
  end
end
