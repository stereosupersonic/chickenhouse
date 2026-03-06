class PostPresenter < ApplicationPresenter
  def html_content
    if o.old_content.present?
      sanitize(o.old_content).html_safe
    else
      o.content
    end
  end

  def author_name
     user&.username.presence || "Anonymous"
  end
end
