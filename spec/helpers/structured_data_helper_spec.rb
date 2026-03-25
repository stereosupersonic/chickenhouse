require "rails_helper"

RSpec.describe StructuredDataHelper, type: :helper do
  describe "#event_structured_data" do
    let(:event) { create(:event, title: "Sommerfest", start_date: 1.day.from_now) }

    it "always includes location" do
      data = helper.event_structured_data(event)

      expect(data["location"]).to be_present
      expect(data["location"]["@type"]).to eq("Place")
    end

    context "when event has a location" do
      let(:event) { create(:event, location: "Sportheim Wartenberg") }

      it "uses the event location as the place name" do
        data = helper.event_structured_data(event)

        expect(data["location"]["name"]).to eq("Sportheim Wartenberg")
      end
    end

    context "when event has no location" do
      let(:event) { create(:event, location: nil) }

      it "falls back to Henaheisl e.V. as the place name" do
        data = helper.event_structured_data(event)

        expect(data["location"]["name"]).to eq("Henaheisl e.V.")
      end
    end

    it "includes an image" do
      data = helper.event_structured_data(event)

      expect(data["image"]).to be_present
      expect(data["image"]).to include("banner_v3")
    end
  end
end
