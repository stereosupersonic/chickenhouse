# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  street     :string(255)
#  plz        :string(255)
#  city       :string(255)
#  mobil      :string(255)
#  email      :string(255)
#  occurs_at  :date
#  birthday   :date
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Member < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :first_name, :last_name, :street, :city, :plz
end
