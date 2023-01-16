# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  body       :text
#  email      :string
#  name       :string
#  subject    :string
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

describe Contact do
  let(:contact) { build(:contact) }

  describe "validation" do
    it "builds a valid factory" do
      expect(contact).to be_valid
    end

    %w[subject body name email].each do |attr_name|
      it "not be valid without a #{attr_name}" do
        contact = build(:contact, attr_name.to_s => nil)

        expect(contact).not_to be_valid
        expect(contact.errors.count).to eq 1
        expect(contact.errors[attr_name.to_s]).to be_present
      end
    end

    it "does not not be vaild without an valid email_address" do
      contact = build(:contact, email: nil)

      expect(contact).not_to be_valid
      expect(contact.errors.count).to eq 1
      expect(contact.errors[:email]).to eq ["is invalid"]
    end
  end

  xit "should send an email" do
    contact.save!

    expect(ActionMailer::Base.deliveries.last).to eq["info@henaheisl.de"]
  end
end
