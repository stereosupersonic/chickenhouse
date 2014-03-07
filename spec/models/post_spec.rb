# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  content                 :text
#  title                   :string(255)
#  intern                  :boolean          default(FALSE)
#  user_id                 :integer
#  media                   :text
#  media_type              :string(255)
#  out_of_date             :datetime
#  content_type            :string(255)      default("article")
#  twitter_export          :boolean          default(TRUE)
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  created_at              :datetime
#  updated_at              :datetime
#

require 'spec_helper'

describe Post do
  describe "validation" do
    it "should create a valid factory" do
      build(:post).should be_valid
    end

    it "should not be valid without a title" do
      build(:post, :title => nil).should have(1).error_on(:title)
    end

  end
end
