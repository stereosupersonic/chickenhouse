# == Schema Information
#
# Table name: posts
#
#  id               :bigint           not null, primary key
#  display_type     :string(255)      default("textile")
#  intern           :boolean          default(FALSE)
#  media            :text
#  old_content      :text
#  old_content_type :string(255)      default("article")
#  slug             :string(255)
#  title            :string(255)      not null
#  visible          :boolean          default(TRUE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#  index_posts_on_visible  (visible)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  OLD_CONTENT_TYPES = %w[article video picture].freeze
  DISPLAY_TYPES = %w[textile raw].freeze

  extend FriendlyId

  friendly_id :title, use: :slugged

  belongs_to :user, optional: true

  scope :visible, -> { where(visible: true) }
  scope :current, -> { where("created_at > ?", 6.months.ago) }

  validates :title, presence: true
  validates :content, presence: true

  has_rich_text :content
end
