# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  attachment_content_type :string
#  attachment_file_name    :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  content                 :text
#  content_type            :string           default("article")
#  display_type            :string           default("textile")
#  intern                  :boolean          default(FALSE)
#  media                   :text
#  media_type              :string
#  out_of_date             :datetime
#  slug                    :string
#  title                   :string
#  twitter_export          :boolean          default(TRUE)
#  visible                 :boolean          default(TRUE)
#  created_at              :datetime
#  updated_at              :datetime
#  album_id                :integer
#  user_id                 :integer
#
# Indexes
#
#  index_posts_on_album_id  (album_id)
#  index_posts_on_intern    (intern)
#  index_posts_on_visible   (visible)
#

require "rails_helper"

describe Post do
  describe "validation" do
    it "should create a valid factory" do
      expect(build(:post)).to be_valid
    end

    it "should not be valid without a title" do
      invalid_post = build(:post, title: nil)

      expect(invalid_post).to_not be_valid
    end
  end

  it "should have a friendly title" do
    post = create(:post, title: "How cool is that")

    expect(post.to_param).to eq "how-cool-is-that"
  end
end
