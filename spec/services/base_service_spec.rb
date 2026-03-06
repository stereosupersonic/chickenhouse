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
    it "instantiates and calls the service" do
      stub_const("TestService", Class.new(BaseService) {
        def initialize(args = nil)
          super()
          @args = args
        end

        def call
          set_result(@args)
          self
        end
      })

      service = TestService.call(foo: "bar")

      expect(service.result).to eq(foo: "bar")
      expect(service.success?).to be true
    end
  end

  describe ".call!" do
    it "validates and calls the service" do
      stub_const("TestService", Class.new(BaseService) {
        def initialize(args = nil)
          super()
        end

        def call
          set_result("done")
          self
        end
      })

      service = TestService.call!(nil)

      expect(service.result).to eq("done")
    end
  end

  describe "#success?" do
    it "returns true when no errors" do
      service = described_class.new

      expect(service.success?).to be true
    end

    it "returns false when errors present" do
      service = described_class.new
      service.send(:add_error, "something went wrong")

      expect(service.success?).to be false
    end
  end

  describe "#failure?" do
    it "returns false when no errors" do
      service = described_class.new

      expect(service.failure?).to be false
    end

    it "returns true when errors present" do
      service = described_class.new
      service.send(:add_error, "something went wrong")

      expect(service.failure?).to be true
    end
  end

  describe "#result" do
    it "is nil by default" do
      service = described_class.new

      expect(service.result).to be_nil
    end

    it "can be set via set_result" do
      service = described_class.new
      service.send(:set_result, "value")

      expect(service.result).to eq("value")
    end
  end
end
