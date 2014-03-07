module BootstrapHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Lesson"
    end
  end

  def page_header(text)
    title text
    content_tag(:h1, text, :class => "page-header" )
  end

   def boolean_value(boolean_value)
    case boolean_value
    when true   then  "Ja"
    when false  then  "Nein"
    else
      ""
    end
  end
end
