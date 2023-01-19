module BootstrapPaginationHelper
  # < WillPaginate::ActionView::LinkRenderer
  class BootstrapLinkRenderer
    protected

    def html_container(html)
      tag(:ul, html, container_attributes)
    end

    def page_number(page)
      tag :li, link(page, page, rel: rel_value(page)), class: ("active" if page == current_page)
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || "#"), class: [classname[0..3], classname, ("disabled" unless page)].join(" ")
    end

    def gap
      tag :li, link(super, "#"), class: "disabled"
    end
  end

  def pagination_links(collection, options = {})
    # options[:renderer] ||= "BootstrapPaginationHelper::BootstrapLinkRenderer"
    options[:page_links] ||= false # shows only previous/next links
    will_paginate(collection, options)
  end

  def paginate(model)
    will_paginate(model)
  end
end
