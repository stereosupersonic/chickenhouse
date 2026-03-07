class PostPresenter < ApplicationPresenter
  def html_content
    if o.old_content.present?
      sanitize(o.old_content).html_safe
    else
      o.content
    end
  end

  def meta_description
    plain = if o.old_content.present?
      ActionController::Base.helpers.strip_tags(o.old_content)
    elsif o.content.present?
      o.content.to_plain_text
    else
      ""
    end
    plain.squish.truncate(160)
  end

  def author_name
     user&.username.presence || "Anonymous"
  end
end
