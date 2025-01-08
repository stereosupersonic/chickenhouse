module ApplicationHelper
  def admin?
    # TODO
    current_user&.admin?
  end

  def current_user
    Current.user
  end

  def current_role
    admin? ? "admin" : "user"
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

  def button_with_icon(text, link, icon, options = {})
    options.reverse_merge! class: "btn btn-default btn-sm"
    link_to tag.i("&nbsp;".html_safe, class: "fa fa-#{icon}") + text, link, options
  end

  def show_button(link, text = "Anzeigen", options = {})
    options.reverse_merge! class: "btn btn-link"
    button_with_icon text, link, "arrow-right", options
  end

  def boolean_value(value)
    case value
    when true then "Ja"
    when false then "Nein"
    else
      ""
    end
  end


  def new_button(link, text = "Neu", options = {})
    add_button link, text, options
  end

  def add_button(link, text = "Neu", options = {})
    options.reverse_merge! class: "btn btn-primary btn-sm"
    button_with_icon text, link, "plus", options
  end

  def edit_button(link, text = "Ändern", options = {})
    link = link.is_a?(ActiveRecord::Base) ? [:edit, link] : link
    options.reverse_merge! class: "btn btn-primary btn-sm"
    button_with_icon text, link, "pencil", options
  end

  def cancel_button(link = root_path, text = "Abbrechen", options = {})
    options.reverse_merge! class: "btn btn-danger btn-sm"
    button_with_icon text, link, "ban", options
  end

  def save_button(link = "#", text = "Speichern", options = {})
    options.reverse_merge! class: "form_submitter btn btn-success btn-sm"
    button_with_icon text, link, "check", options
  end

  def delete_button(link, text = "Löschen", options = {})
    options.reverse_merge! data: { confirm: "Sind Sie sicher?" }, method: :delete, class: "form_submitter btn btn-danger btn-sm"
    button_with_icon text, link, "trash-o", options
  end

  def back_button(link, text = I18n.t("common.actions.back"), options = {})
    options.reverse_merge! class: "btn btn-default btn-sm"
    button_with_icon text, link, "arrow-left", options
  end

end
