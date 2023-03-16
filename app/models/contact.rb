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
  validates :name, :subject, :body, presence: true
  validates :email, email: true

  after_save :send_email

  def balh(a)
    1 +2
  end
  def send_email
    # ContactMailer.contact(self).deliver!
  end
end
