require 'spec_helper'


describe PostsController do

  let(:object)            { create :post }

  it_behaves_like :a_resource_controller_with_only_read_access

end
