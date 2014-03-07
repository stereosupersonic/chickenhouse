require 'spec_helper'

<% module_namespacing do -%>
describe <%= class_name %>Controller do

  render_views

  let(:object)            { create :<%= class_name %> }
  let(:required_field)    { "#TODO" }

  before { login_as_TODO }
  it_behaves_like :a_resource_controller_with_destroy

end
<% end -%>
