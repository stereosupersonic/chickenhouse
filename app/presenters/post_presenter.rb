class PostPresenter < ApplicationPresenter
  def html_content
    if o.display_type.to_s == "raw"
      sanitize(o.content).html_safe
    else
      sanitize(o.content).html_safe
    end
  end

  def author_name
    o.author || "Anonymous"
  end
end
