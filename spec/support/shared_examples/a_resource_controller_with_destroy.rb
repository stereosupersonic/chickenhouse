shared_examples :a_resource_controller_with_destroy do | _options|
  it_behaves_like :a_resource_controller, _options do | options |

    def _base_params
      respond_to?(:base_params) ? base_params : {}
    end

    describe "DELETE destroy" do
      before { object.save! }

      def do_delete
        delete :destroy, _base_params.merge(:id => object.id)
      end

      it "redirects" do
        do_delete
        response.should be_redirect
      end

      it "destroys the object" do
        expect { do_delete }.to change(object.class, :count).by(-1)
      end

      it "show flash notice" do
        do_delete
        flash[:notice].should_not be_blank
      end
    end
  end
end
