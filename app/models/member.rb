# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  birthday   :date
#  city       :string
#  email      :string
#  first_name :string
#  last_name  :string
#  mobil      :string
#  occurs_at  :date
#  plz        :string
#  street     :string
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Member < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :street, :city, :plz, presence: true
  def years
    (Time.zone.now.to_date - occurs_at).to_i / 360 if occurs_at
  end
end
