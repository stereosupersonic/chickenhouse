require 'spec_helper'

describe Admin::PhotosController do

  render_views

  let(:object)            { create :photo }
  let(:required_field)    { :flickr_id }

  before { login_as_admin }
  it_behaves_like :a_resource_controller_with_destroy, :excluded_actions => [:new, :create,:show]

end
