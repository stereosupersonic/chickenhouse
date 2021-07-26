# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  body       :text
#  email      :string
#  name       :string
#  subject    :string
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ApplicationRecord

  validates_presence_of :name, :subject, :body
  validates :email, :email => true
  after_save :send_email

  def send_email
    ContactMailer.contact(self).deliver!
  end

end
