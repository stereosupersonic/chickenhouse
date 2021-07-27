# == Schema Information
#
# Table name: collections
#
#  id                 :integer          not null, primary key
#  flickr_description :text
#  flickr_title       :string
#  iconlarge          :string
#  iconsmall          :string
#  slug               :string
#  created_at         :datetime
#  updated_at         :datetime
#  flickr_id          :string
#

require "rails_helper"

describe Collection do
  pending "add some examples to (or delete) #{__FILE__}"
end
