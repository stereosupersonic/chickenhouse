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

  def format_time(time)
    time.strftime '%H:%M' if time
  end

  def format_date(date)
    date.strftime '%d.%m.%Y' if date
  end

  def format_datetime(date)
    date.strftime '%d.%m.%Y %H:%M' if date
  end

  def youtube_video(video_id)
    embed_code = '<iframe src="http://www.youtube.com/embed/' + h(video_id) + '" frameborder="0" allowfullscreen></iframe>'
    embed_code.html_safe
  end

  def extract_youtube_id_from_url(url)
    CGI.parse(URI.parse(url).query)["v"].first
  end

  def detect_youtube_url(line)
    regexp = /http:\/\/www.youtube.com\/watch\?[^\s]*/
    match = line.match(regexp)
    match[0] if match
  end
end
