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
#  slug                    :string(255)
#

class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :user
  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment

  validates_presence_of :title

  def html_content
    RedCloth.new(content).to_html.html_safe
  end
end
