module ApplicationHelper
  
  include BootstrapHelper
  include BootstrapPaginationHelper

  def error_messages_for( symbol)
    model_object = instance_variable_get "@#{symbol}"
    if model_object && model_object.errors.any?
      lines = model_object.errors.full_messages.collect { |msg| "<li>#{h(msg)}</li>" }.join
      "<div id='error_explanation'><ul>#{lines}</ul> </div>".html_safe
    end
  end

  
  def youtube_video(video_id)
    embed_code = '<iframe src="http://www.youtube.com/embed/' + h(video_id) + '" frameborder="0" allowfullscreen></iframe>'
    embed_code.html_safe
  end

  def extract_youtube_id_from_url(url)
    CGI.parse(URI.parse(url).query)["v"].first
  end
  
  # date/time
  def format_time(time)
    time&.strftime "%H:%M"
  end

  def format_date(date)
    date&.strftime "%d.%m.%Y"
  end

  def format_datetime(date)
    date&.strftime "%d.%m.%Y %H:%M"
  end

  # buttons
  def icon_tag(icon, options = {})
    html_class = "fa fa-#{icon} " + options[:class].to_s
    content_tag(:i, "&nbsp;".html_safe, class: html_class) # rubocop:disable Rails/OutputSafety
  end

  def button_with_icon(link, text, icon, options = {})
    options.reverse_merge! class: "btn btn-default"
    link_to icon_tag(icon) + text, link, options
  end

  def show_button(link, text = "Show", options = {})
    options.reverse_merge! class: "btn btn-info"
    button_with_icon link, text, "link", options
  end

  def add_button(link, text = "Add", options = {})
    options.reverse_merge! class: "btn btn-primary add-button"
    button_with_icon link, text, "plus", options
  end

  def edit_button(link, text = "Edit", options = {})
    link = link.is_a?(ActiveRecord::Base) ? [:edit, link] : link
    options.reverse_merge! class: "btn btn-primary"
    button_with_icon link, text, "pencil", options
  end

  def submit_button(text = "Save", options = {})
    options.reverse_merge! class: "btn btn-success", type: "submit"
    button_tag options do
      icon_tag(:check) + safe_join([text])
    end
  end

  def remove_button(link, text = "Remove", options = {})
    options.reverse_merge! data: {confirm: "Are you sure?"}, class: "btn btn-danger"
    button_with_icon link, text, "trash", options
  end

  def delete_button(link, text = "Delete", options = {})
    options.reverse_merge! data: {confirm: "Are you sure?"},
                           method: :delete, class: "btn btn-danger"
    button_with_icon link, text, "trash", options
  end

  def back_button(link = :back, text = "Back", options = {})
    options.reverse_merge! class: "btn btn-default"
    button_with_icon link, text, "arrow-left", options
  end

  def cancel_button(link = :back, text = "Cancel", options = {})
    options.reverse_merge! class: "btn btn-danger"
    button_with_icon link, text, "remove", options
  end

  def show_boolean_value(value)
    if value
      icon_tag :check, class: "text-success"
    else
      icon_tag :times, class: "text-danger"
    end
  end
end