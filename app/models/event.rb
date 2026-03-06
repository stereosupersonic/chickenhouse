# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  all_day    :boolean          default(FALSE)
#  content    :text             not null
#  created_at :datetime         not null
#  end_date   :datetime
#  location   :string(255)
#  slug       :string           not null
#  start_date :datetime         not null
#  title      :string(255)      not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  visible    :boolean          default(TRUE), not null
#
# Indexes
#
#  index_events_on_slug        (slug) UNIQUE
#  index_events_on_start_date  (start_date)
#  index_events_on_user_id     (user_id)
#  index_events_on_visible     (visible)
#

class Event < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 10_000 }
  validates :location, length: { maximum: 255 }
  validates :slug, presence: true, uniqueness: true
  validates :start_date, presence: true

  belongs_to :user

  scope :visible, -> { where(visible: true) }

  scope :next_events, -> { visible.where(start_date: Time.zone.now.beginning_of_day..).order(:start_date) }

  def self.next_event
    next_events.first
  end

  def self.by_slug(slug)
    friendly.find slug
  end
end
