# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#

require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
  end

  describe "validations" do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.to validate_uniqueness_of(:email_address).ignoring_case_sensitivity }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }

    describe "email_address format validation" do
      it "accepts valid email addresses" do
        valid_emails = [
          "user@example.com",
          "test.email@domain.co.uk",
          "user+tag@example.org"
        ]

        valid_emails.each do |email|
          user = build(:user, email_address: email)
          expect(user).to be_valid, "Expected #{email} to be valid"
        end
      end

      it "rejects invalid email addresses" do
        invalid_emails = [
          "plainaddress",
          "@missingdomain.com",
          "missing@.com",
          "missing-domain@.com",
          "spaces in@email.com"
        ]

        invalid_emails.each do |email|
          user = build(:user, email_address: email)
          expect(user).not_to be_valid, "Expected #{email} to be invalid"
          expect(user.errors[:email_address]).to include("must be a valid email address")
        end
      end
    end

    describe "password validation" do
      it "validates password length" do
        user = build(:user, password: "short", password_confirmation: "short")
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("must be at least 8 characters long")
      end

      it "accepts passwords with 8 or more characters" do
        user = build(:user, password: "password123", password_confirmation: "password123")
        expect(user).to be_valid
      end

      it "allows nil password for updates" do
        user = create(:user)
        user.username = "newusername"
        user.save!(validate: false)
        user.reload
        user.email_address = "new@example.com"
        expect(user).to be_valid
      end
    end

    describe "username validation" do
      it "validates minimum length" do
        user = build(:user, username: "ab")
        expect(user).not_to be_valid
        expect(user.errors[:username]).to be_present
      end

      it "validates maximum length" do
        user = build(:user, username: "a" * 51)
        expect(user).not_to be_valid
        expect(user.errors[:username]).to be_present
      end

      it "accepts usernames within valid range" do
        user = build(:user, username: "validuser")
        expect(user).to be_valid
      end
    end
  end

  describe "normalizations" do
    it "normalizes email_address by stripping whitespace and downcasing" do
      user = create(:user, email_address: "  TEST@EXAMPLE.COM  ")
      expect(user.email_address).to eq("test@example.com")
    end

    it "normalizes username by stripping whitespace" do
      user = create(:user, username: "  testuser  ")
      expect(user.username).to eq("testuser")
    end
  end

  describe "secure password" do
    it "has secure password functionality" do
      user = build(:user, password: "password123")
      expect(user).to respond_to(:authenticate)
      expect(user).to respond_to(:password_digest)
    end

    it "authenticates with correct password" do
      user = create(:user, password: "password123")
      expect(user.authenticate("password123")).to eq(user)
    end

    it "does not authenticate with incorrect password" do
      user = create(:user, password: "password123")
      expect(user.authenticate("wrongpassword")).to be_falsey
    end
  end

  describe "database constraints" do
    it "enforces email uniqueness at database level" do
      create(:user, email_address: "test@example.com")

      duplicate_user = described_class.new(email_address: "test@example.com", username: "different", password: "password123")
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email_address]).to include("ist bereits vergeben")
    end
  end

  describe "factory" do
    it "creates a valid user" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "creates a valid admin user" do
      admin = build(:admin)
      expect(admin).to be_valid
      expect(admin.admin).to be true
    end
  end
end
