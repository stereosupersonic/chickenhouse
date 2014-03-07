# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe User do
  describe "validation" do
    it "should build a valid factory" do
      build(:user).should be_valid
    end

    it "should build a valid factory for admin" do
      build(:admin).should be_valid
    end

    it "should create as admin" do
      create(:admin).should be_admin
    end
  end

  describe "reset_admin" do
    it "should not be valid without a title" do
      expect do
        User.reset_admin(12345)
      end.to change(User,:count).by(1)
    end

    it "should create as admin" do
      User.reset_admin(12345).should be_admin
    end

    it "should create as admin as name" do
      User.reset_admin(12345).username.should == 'admin'
    end
  end
end
