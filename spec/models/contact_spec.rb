# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  body       :text
#  email      :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Contact do

  describe 'validation' do
    it "should build a valid factory" do
      build(:contact).should be_valid
    end

    %w{subject body name email}.each do |attr_name|
      it "not be valid without a #{attr_name}" do
        build(:contact, "#{attr_name}" => nil).should have(1).errors_on("#{attr_name}")
      end
    end

    it "should not not be vaild without an valid email_address" do
      build(:contact, :email => 'some blah').should have(1).errors_on(:email)
    end
  end

  it "should send an email" do
    build(:contact).save!
    ActionMailer::Base.deliveries.last.to.should == ['info@henaheisl.de']
  end
end
