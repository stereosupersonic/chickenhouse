class PostPresenter < ApplicationPresenter
  def html_content
    if o.old_content.present?
      h.sanitize(o.old_content)
    else
      o.content
    end
  end

  def meta_description
    plain = if o.old_content.present?
      h.strip_tags(o.old_content)
    else
      o.content.to_plain_text
    end
    plain.squish.truncate(160)
  end

  def author_name
    o.user.username
  end
end
