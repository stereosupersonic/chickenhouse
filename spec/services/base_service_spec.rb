require "rails_helper"

RSpec.describe BaseService do
  describe "#call" do
    it "raises NotImplementedError" do
      expect {
        described_class.new.call
      }.to raise_error(NotImplementedError, "Subclasses must implement the call method")
    end
  end

  describe ".call" do
    it "instantiates with the given attributes and calls the service" do
      stub_const("TestService", Class.new(BaseService) {
        attr_accessor :foo

        def call
          foo
        end
      })

      expect(TestService.call(foo: "bar")).to eq("bar")
    end
  end
end
