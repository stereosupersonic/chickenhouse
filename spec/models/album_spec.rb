# == Schema Information
#
# Table name: albums
#
#  id                 :integer          not null, primary key
#  flickr_id          :string(255)
#  flickr_description :text
#  flickr_title       :string(255)
#  iconsmall          :string(255)
#  iconlarge          :string(255)
#  collection_id      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Album do
  pending "add some examples to (or delete) #{__FILE__}"
end
