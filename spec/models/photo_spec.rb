# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  flickr_id          :string(255)
#  flickr_description :text
#  flickr_title       :string(255)
#  url_icon           :string(255)
#  url_big            :string(255)
#  album_id           :integer          indexed
#  created_at         :datetime
#  updated_at         :datetime
#  url_original       :string(255)
#  slug               :string(255)
#  url_small          :string(255)
#  taken_at           :datetime         indexed
#  visible            :boolean          default(TRUE), indexed
#

require 'spec_helper'

describe Photo do
  pending "add some examples to (or delete) #{__FILE__}"
end
