module ApplicationHelper
  include Pagy::Frontend

  def youtube_video(video_id, title: "YouTube Video")
    tag.iframe(
      src: "https://www.youtube.com/embed/#{h(video_id)}",
      title: title,
      allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture",
      allowfullscreen: true,
      loading: "lazy"
    )
  end

  def admin?
    current_user&.admin?
  end

  def current_user
    Current.user
  end

  def format_date(date)
    date.strftime "%d.%m.%Y"
  end

  def format_datetime(date)
    return "" if date.nil?
    date.strftime "%d.%m.%Y %H:%M"
  end

  def button_with_icon(text, link, icon, options)
    link_to tag.i("&nbsp;".html_safe, class: "fa-solid fa-#{icon}") + text, link, options
  end

  def new_button(link)
    button_with_icon "Neu", link, "plus", class: "btn btn-primary btn-sm"
  end

  def edit_button(link)
    button_with_icon "Ändern", link, "pen", class: "btn btn-primary btn-sm"
  end

  def cancel_button(link)
    button_with_icon "Abbrechen", link, "ban", class: "btn btn-danger btn-sm"
  end

  def delete_button(link)
    button_with_icon "Löschen", link, "trash",
                     data: { turbo_method: :delete, turbo_confirm: "Are you sure?" }, class: "btn btn-danger btn-sm"
  end

  def back_button(link)
    button_with_icon I18n.t("common.actions.back"), link, "arrow-left", class: "btn btn-light"
  end

  def boolean_value(value)
    case value
    when true then "Ja"
    when false then "Nein"
    else
      ""
    end
  end
end
