require 'spec_helper'

describe Admin::MembersController do

  render_views

  let(:object)            { create :Admin::Members }
  let(:required_field)    { "#TODO" }

  before { login_as_TODO }
  it_behaves_like :a_resource_controller_with_destroy

end
