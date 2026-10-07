require "rails_helper"

RSpec.describe "Active Storage representations", type: :request do
  describe "GET /rails/active_storage/representations" do
    let(:blob) do
      ActiveStorage::Blob.create_and_upload!(
        io: file_fixture("image.png").open,
        filename: "image.png",
        content_type: "image/png"
      )
    end

    it "redirects to the resized image" do
      get rails_representation_path(blob.representation(resize_to_limit: [ 1024, 768 ]))

      expect(response).to have_http_status(:redirect)
    end
  end
end
