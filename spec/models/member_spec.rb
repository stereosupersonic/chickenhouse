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

require "rails_helper"

describe Member do
  describe "validation" do
    it "builds a valid factory" do
      build(:member).should be_valid
    end
  end
end
