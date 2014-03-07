require 'spec_helper'

describe Admin::EventsController do

  render_views

  let(:object)            { create :event }
  let(:required_field)    { :title }

  before { login_as_admin }

  it_behaves_like :a_resource_controller_with_destroy

end
