# == Schema Information
#
# Table name: collections
#
#  id                 :integer          not null, primary key
#  flickr_id          :string(255)
#  flickr_description :text
#  flickr_title       :string(255)
#  iconsmall          :string(255)
#  iconlarge          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Collection do
  pending "add some examples to (or delete) #{__FILE__}"
end
