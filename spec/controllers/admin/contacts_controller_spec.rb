require 'spec_helper'

describe Admin::ContactsController do

  render_views

  let(:object)            { create :contact }

  before { login_as_admin}
  it_behaves_like :a_resource_controller_with_only_read_access
end
