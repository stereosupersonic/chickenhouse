shared_examples :a_resource_controller_denying_access do | options |

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

      it "should fail" do
        do_get
        response.should_not be_success
      end
    end
  end

  unless excluded_actions.include?(:show)
    describe "GET show" do
      before { object.save! }

      def do_get
        get :show, _base_params.merge(:id => object.id)
      end

      it "should fail" do
        do_get
        response.should_not be_success
      end
    end
  end


  unless excluded_actions.include?(:create)
    describe "POST create" do
      def do_post
        post :create, _base_params.merge(object_symbol => FactoryGirl.attributes_for(object_symbol))
      end

      it "should fail" do
        do_post
        response.should_not be_success
      end
    end
  end


  unless excluded_actions.include?(:edit)
    describe "GET edit" do
      before { object.save! }

      def do_get
        get :edit, _base_params.merge(:id => object.id)
      end

      it "should fail" do
        do_get
        response.should_not be_success
      end
    end
  end

  unless excluded_actions.include?(:update)
    describe "PUT update" do
      before { object.save! }

      def do_put
        put :update, _base_params.merge(:id => object.id, object_symbol => FactoryGirl.attributes_for(object_symbol))
      end

      it "should fail" do
        do_put
        response.should_not be_success
      end
    end
  end
end
