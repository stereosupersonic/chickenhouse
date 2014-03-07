shared_examples :a_resource_controller_with_destroy_denying_access do | _options |
  it_behaves_like :a_resource_controller_denying_access, _options do |options |

    def _base_params
      respond_to?(:base_params) ? base_params : {}
    end

    describe "DELETE destroy" do
      before { object.save! }

      def do_delete
        delete :destroy, _base_params.merge(:id => object.id)
      end

      it "should fail" do
        do_delete
        response.should_not be_success
      end
    end
  end
end
