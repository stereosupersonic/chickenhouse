# Methods added to this helper will be available to all templates in the application.
module BootstrapButtonHelper
  def button_with_icon(text, link, icon, options = {})
    options.reverse_merge! class: "btn btn-default btn-sm"
    link_to content_tag(:i, "&nbsp;".html_safe, class: "fa fa-#{icon}") + text, link, options
  end

  def export_button(text, link, options = {})
    button_with_icon text, link, "download", options
  end

  def search_button(link = "#", text = "Suchen", options = {})
    options.reverse_merge! class: "form_submitter btn btn-default btn-sm"
    button_with_icon text, link, "search", options
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
    options.reverse_merge! data: {confirm: "Sind Sie sicher?"}, method: :delete, class: "form_submitter btn btn-danger btn-sm"
    button_with_icon text, link, "trash-o", options
  end

  def deactivating_button(link, text = "Deaktivieren", options = {})
    options.reverse_merge! data: {confirm: "Sind Sie sicher?"}, method: :delete, class: "form_submitter btn btn-danger btn-sm"
    button_with_icon text, link, "minus-circle", options
  end

  def activation_button(link, text = "Aktivieren", options = {})
    options.reverse_merge! data: {confirm: "Sind Sie sicher?"}, method: :delete, class: "form_submitter btn btn-success btn-sm"
    button_with_icon text, link, "check-circle", options
  end

  def back_button(link, text = I18n.t("common.actions.back"), options = {})
    options.reverse_merge! class: "btn btn-default btn-sm"
    button_with_icon text, link, "arrow-left", options
  end

  def show_button(link, text = "Anzeigen", options = {})
    options.reverse_merge! class: "btn btn-link"
    button_with_icon text, link, "arrow-right", options
  end

  def info_button(link, text = "Info", options = {})
    options.reverse_merge! class: "btn btn-info btn-sm"
    button_with_icon text, link, "info-circle", options
  end

  def revert_button(link, text = "zurücksetzen", options = {})
    options.reverse_merge! class: "btn btn-default btn-sm"
    button_with_icon text, link, "repeat", options
  end

  def copy_button(link, text = "kopieren", options = {})
    options.reverse_merge! class: "btn btn-primary btn-sm"
    button_with_icon text, link, "copy", options
  end
end
