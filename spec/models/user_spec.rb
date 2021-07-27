# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean          default(FALSE)
#  email           :string
#  password_digest :string
#  slug            :string
#  username        :string
#  created_at      :datetime
#  updated_at      :datetime
#

require "rails_helper"

describe User do
  describe "validation" do
    it "builds a valid factory" do
      expect(build(:user)).to be_valid
    end

    it "builds a valid factory for admin" do
      expect(build(:admin)).to be_valid
    end

    it "creates as admin" do
      expect(create(:admin)).to be_admin
    end
  end

  describe "reset_admin" do
    it "is not valid without a title" do
      expect do
        described_class.reset_admin("12345")
      end.to change(described_class, :count).by(1)
    end

    it "creates as admin" do
      described_class.reset_admin("12345").should be_admin

      expect(described_class.reset_admin("12345")).to be_admin
    end

    it "creates as admin as name" do
      expect(described_class.reset_admin("12345").username).to eq "admin"
    end
  end
end
