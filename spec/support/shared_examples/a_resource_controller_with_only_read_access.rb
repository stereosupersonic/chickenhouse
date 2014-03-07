shared_examples :a_resource_controller_with_only_read_access do | options|

  excluded_actions ||= options ? options[:excluded_actions].to_a : []
  render_views

  let(:object_symbol) { object.class.to_s.underscore.to_sym }

  def _base_params
    respond_to?(:base_params) ? base_params : {}
  end

  unless excluded_actions.include?(:index)
    describe "GET index" do
      before { object.save! }

      def do_get
        get :index, _base_params
      end

      it "should succeed" do
        do_get
        response.should be_success
      end

      it "should load objects" do
        do_get
        assigns[object_symbol.to_s.pluralize.to_sym].should include(object)
      end
    end
  end

  unless excluded_actions.include?(:show)
    describe "GET show" do
      before { object.save! }

      def do_get
        get :show, _base_params.merge(:id => object.id)
      end

      it "should succeed" do
        do_get
        response.should be_success
      end

      it "should load object" do
        do_get
        assigns[object_symbol].should == object
      end
    end
  end
end
