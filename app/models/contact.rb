# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  body       :text
#  email      :string(255)
#  name       :string(255)
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
