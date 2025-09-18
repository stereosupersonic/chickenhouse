class PostPresenter < ApplicationPresenter
  def html_content
    if o.old_content.present?
      if o.display_type.to_s == "raw"
        sanitize(o.old_content).html_safe
      else
        sanitize(o.old_content).html_safe
      end
    else
      o.content
    end
  end

  def author_name
     user&.username.presence || "Anonymous"
  end
end
