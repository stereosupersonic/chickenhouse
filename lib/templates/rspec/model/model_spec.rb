require 'spec_helper'

<% module_namespacing do -%>
describe <%= class_name %> do
  describe 'validation' do
    it "should build a valid factory" do
      build(:<%= class_name %>).should be_valid
    end
  end
end
<% end -%>
