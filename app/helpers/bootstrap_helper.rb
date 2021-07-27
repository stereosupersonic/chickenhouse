module BootstrapHelper
  def title(value)
    @title = "#{value} | Lesson" unless value.nil?
  end

  def page_header(text)
    title text
    tag.h1(text, class: "page-header")
  end

  def boolean_value(boolean_value)
    case boolean_value
    when true then "Ja"
    when false then "Nein"
    else
      ""
    end
  end
end
