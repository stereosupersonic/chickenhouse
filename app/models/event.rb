# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  location   :string(255)
#  start_date :datetime         indexed
#  end_date   :datetime
#  all_day    :boolean
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#  visible    :boolean          default(TRUE), indexed
#

class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, :use => :slugged

  validates_presence_of :title

  belongs_to :user

  scope :visible, -> { where(:visible => true) }

  scope :next_events, lambda { visible.where("start_date >= ? ", Time.now).order('start_date') }

  def self.next_event
    next_events.first
  end

  def html_content
    RedCloth.new(content).to_html.html_safe
  end
end
