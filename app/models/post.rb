# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  content                 :text
#  title                   :string(255)
#  intern                  :boolean
#  user_id                 :integer
#  postable_id             :integer          indexed
#  postable_type           :string(20)       indexed, indexed => [out_of_date]
#  created_at              :datetime
#  updated_at              :datetime
#  out_of_date             :datetime         indexed => [postable_type], indexed
#  tweet_id                :integer
#  tags                    :text
#  content_type            :string(255)      default("article")
#  media                   :text
#  media_type              :string(255)      default("")
#  twitter_export          :boolean          default(TRUE)
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#

class Post < ActiveRecord::Base

  belongs_to :user
  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment

  validates_presence_of :title

  def html_content
    RedCloth.new(content).to_html.html_safe
  end
end
