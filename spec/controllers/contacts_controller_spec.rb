require 'spec_helper'

describe ContactsController do

  render_views

  let(:object)            { create :contact }
  let(:required_field)    { :subject }

  it_behaves_like :a_resource_controller, :excluded_actions => [:update,:edit,:destroy,:show,:index]

end
