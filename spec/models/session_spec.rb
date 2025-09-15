# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  ip_address :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#

require "rails_helper"

RSpec.describe Session, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it "is valid with a user" do
      session = build(:session)
      expect(session).to be_valid
    end

    it "is invalid without a user" do
      session = build(:session, user: nil)
      expect(session).not_to be_valid
    end
  end

  describe "attributes" do
    it "can store ip_address" do
      session = create(:session, ip_address: "192.168.1.1")
      expect(session.ip_address).to eq("192.168.1.1")
    end

    it "can store user_agent" do
      user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
      session = create(:session, user_agent: user_agent)
      expect(session.user_agent).to eq(user_agent)
    end

    it "allows nil ip_address and user_agent" do
      session = create(:session, ip_address: nil, user_agent: nil)
      expect(session).to be_valid
      expect(session.ip_address).to be_nil
      expect(session.user_agent).to be_nil
    end
  end

  describe "database constraints" do
    it "enforces user_id presence at database level" do
      session = described_class.new(user_id: nil, ip_address: "127.0.0.1")
      expect(session).not_to be_valid
      expect(session.errors[:user]).to be_present
    end
  end

  describe "timestamps" do
    it "automatically sets created_at and updated_at" do
      session = create(:session)
      expect(session.created_at).to be_present
      expect(session.updated_at).to be_present
    end
  end

  describe "factory" do
    it "creates a valid session" do
      session = build(:session)
      expect(session).to be_valid
    end
  end
end
