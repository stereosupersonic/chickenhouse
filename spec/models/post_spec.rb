# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  content                 :text
#  title                   :string(255)
#  intern                  :boolean          default(FALSE), indexed
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
#  slug                    :string(255)
#  album_id                :integer          indexed
#  visible                 :boolean          default(TRUE), indexed
#  display_type            :string(255)      default("textile")
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

  it "should have a friendly title" do
     create(:post, :title => 'How cool is that').to_param.should == 'how-cool-is-that'
  end

end
