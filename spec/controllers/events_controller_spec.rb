require 'spec_helper'

describe EventsController do

  render_views

  let(:object)            { create :event }

  it_behaves_like :a_resource_controller_with_only_read_access

end
