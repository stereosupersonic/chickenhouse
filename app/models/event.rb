# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  all_day    :boolean
#  content    :text
#  end_date   :datetime
#  location   :string
#  slug       :string
#  start_date :datetime
#  title      :string
#  visible    :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#
# Indexes
#
#  index_events_on_start_date  (start_date)
#  index_events_on_visible     (visible)
#

class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true

  belongs_to :user

  scope :visible, -> { where(visible: true) }

  scope :next_events, -> { visible.where("start_date >= ? ", Time.zone.now).order("start_date") }

  def self.next_event
    next_events.first
  end

  def html_content
    content.html_safe
    # RedCloth.new(content).to_html.html_safe
  end
end
