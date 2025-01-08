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

class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user, optional: true
  belongs_to :album, optional: true

  scope :visible, -> { where(visible: true) }
  scope :current, -> { where("created_at > ?", 6.months.ago) }

  # has_attached_file :attachment
  # do_not_validate_attachment_file_type :attachment

  validates :title, presence: true

  def html_content
    if display_type.to_s == "raw"
      content.html_safe
    else
      content.html_safe
      # RedCloth.new(content).to_html.html_safe
    end
  end

  def author
    user.try(:email_address) || "Anonymous"
  end
end
