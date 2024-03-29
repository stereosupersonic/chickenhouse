inputs = %w[
  CollectionSelectInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
  TextInput
]

inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize

  new_class = Class.new(superclass) do
    def input_html_classes
      super.push("form-control")
    end
  end

  Object.const_set(input_type, new_class)
end

SimpleForm.setup do |config|
  config.boolean_style = :inline
  config.wrappers :bootstrap, tag: "div", class: "form-group", error_class: "error field_with_errors" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: "div", class: "controls" do |ba|
      ba.use :input
      ba.use :error, wrap_with: {tag: "span", class: "help-inline"}
      ba.use :hint, wrap_with: {tag: "p", class: "help-block"}
    end
  end

  config.wrappers :prepend, tag: "div", class: "control-group", error_class: "error" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: "div", class: "controls" do |input|
      input.wrapper tag: "div", class: "input-prepend" do |prepend|
        prepend.use :input
      end
      input.use :hint, wrap_with: {tag: "span", class: "help-block"}
      input.use :error, wrap_with: {tag: "span", class: "help-inline"}
    end
  end

  config.wrappers :append, tag: "div", class: "control-group", error_class: "error" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.use :input
    b.use :error, wrap_with: {tag: "span", class: "help-inline"}
    b.use :hint, wrap_with: {tag: "p", class: "help-block"}
  end

  config.wrappers :inline_checkbox, tag: "div", class: "checkbox", error_class: "has-error" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label_input
  end

  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :bootstrap
end
