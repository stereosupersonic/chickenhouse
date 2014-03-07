#to use add
#let(:object)         {create :some_object}
#let(:required_field) {:some_required_field_name}

shared_examples :a_resource_controller do | options |

  excluded_actions ||= options ? options[:excluded_actions].to_a : []
  render_views

  let(:object_symbol) { object.class.to_s.underscore.to_sym }

  it_behaves_like :a_resource_controller_with_only_read_access, options

  def _base_params
    respond_to?(:base_params) ? base_params : {}
  end

  unless excluded_actions.include?(:create)
    describe "POST create" do
      def do_post
        post :create, _base_params.merge(object_symbol => object_params)
      end

      context "with valid params" do
        let(:object_params) { respond_to?(:valid_object_params) ? valid_object_params : attributes_for(object_symbol) }

        it "should redirect" do
          do_post
          response.should be_redirect
        end

        it "should create object" do
          expect { do_post }.to change(object.class, :count).by(1)
        end

        it "should set flash notice" do
          do_post
          flash[:notice].should_not be_blank
        end
      end

      context "with invalid params" do
        let(:object_params) { respond_to?(:invalid_object_params) ? invalid_object_params : attributes_for(object_symbol, required_field => nil) }

        it "should succeed" do
          unless !respond_to?(:invalid_object_params) and required_field.blank?
            do_post
            response.should be_success
          end
        end

        it "should not create object" do
          unless !respond_to?(:invalid_object_params) and required_field.blank?
            expect { do_post }.to_not change(object.class, :count)
          end
        end

        it "should render edit template" do
          unless !respond_to?(:invalid_object_params) and required_field.blank?
            do_post
            response.should render_template("new")
          end
        end
      end
    end
  end

  unless excluded_actions.include?(:edit)
    describe "GET edit" do
      before { object.save! }

      def do_get
        get :edit, _base_params.merge(:id => object.id)
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

  unless excluded_actions.include?(:update)
    describe "PUT update" do
      before { object.save! }

      def do_put
        put :update, _base_params.merge(:id => object.id, object_symbol => object_params)
      end

      context "with valid params" do
        let(:object_params) { respond_to?(:valid_object_params) ? valid_object_params : attributes_for(object_symbol) }

        it "should redirect" do
          do_put
          response.should be_redirect
        end

        it "should set flash notice" do
          do_put
          flash[:notice].should_not be_blank
        end
      end

      context "with invalid params" do
        let(:object_params) { respond_to?(:invalid_object_params) ? invalid_object_params : attributes_for(object_symbol, required_field => nil) }

        it "should succeed" do
          unless !respond_to?(:invalid_object_params) and required_field.blank?
            do_put
            response.should be_success
          end
        end

        it "should render edit template" do
          unless !respond_to?(:invalid_object_params) and required_field.blank?
            do_put
            response.should render_template("edit")
          end
        end
      end
    end
  end
end
