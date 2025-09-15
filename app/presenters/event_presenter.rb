class EventPresenter < ApplicationPresenter
  def html_content
    simple_format(sanitize(o.content))
  end

  def formatted_start_date
    return "" if o.start_date.blank?

    if o.all_day?
      o.start_date.strftime("%B %d, %Y")
    else
      o.start_date.strftime("%B %d, %Y at %l:%M %p")
    end
  end

end
