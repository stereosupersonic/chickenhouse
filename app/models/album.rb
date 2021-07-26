# == Schema Information
#
# Table name: albums
#
#  id                 :integer          not null, primary key
#  flickr_description :text
#  flickr_title       :string
#  iconlarge          :string
#  iconsmall          :string
#  slug               :string
#  visible            :boolean          default(TRUE)
#  created_at         :datetime
#  updated_at         :datetime
#  collection_id      :integer
#  flickr_id          :string
#  main_photo_id      :integer
#
# Indexes
#
#  index_albums_on_collection_id  (collection_id)
#  index_albums_on_visible        (visible)
#

class Album < ApplicationRecord

  extend FriendlyId
  friendly_id :flickr_title, :use => :slugged

  belongs_to :collection
  belongs_to :main_photo, :class_name => "Photo"
  has_many :photos, -> { where(:visible => true).order('taken_at') }
  has_one :post

  scope :by_year, lambda { |year| where(:created_at => Date.parse("#{year}.1.1").beginning_of_year..Date.parse("#{year}.1.1").end_of_year).where(:visible => true).order('created_at') }

#  include FlickrHelper
  def flickr_info
    @flickr_info ||= flickr_access.photosets.getInfo :photoset_id => flickr_id
  end

  def flickr_photos
    @flickr_photos ||= flickr_access.photosets.getPhotos(:photoset_id => flickr_id,
                                                         :extras => 'license, date_upload, date_taken, owner_name, icon_server, original_format, last_update, geo, tags, machine_tags, o_dims, views, media, path_alias, url_sq, url_c, url_l, url_s, url_m, url_o')
  end

  def name
    flickr_title.titleize
  end

  def name_without_year
    name.gsub(/\d{4}/,'')
  end

  def reload_from_flickr!
    self.flickr_id             = flickr_info['id']
    self.flickr_title          = flickr_info['title']
    self.flickr_description    = flickr_info['description']
    Photo.delete_all("album_id = #{self.id}")
    self.reload
    flickr_photos.to_hash['photo'].each do |photo_hash|
      self.photos.find_or_create_by_flickr_id(photo_hash['id']) do |photo|
        photo.flickr_id    = photo_hash['id']
        photo.flickr_description = photo_hash['title']
        photo.flickr_title = photo_hash['title'].presence || photo_hash['id']
        photo.url_icon     = photo_hash['url_sq']
        photo.url_big      = photo_hash['url_l']
        photo.url_original = photo_hash['url_o']
        photo.url_small    = photo_hash['url_s']
        photo.taken_at     = photo_hash['datetaken'].to_datetime
        photo.created_at   = photo_hash['datetaken'].to_datetime
        photo.updated_at   = photo_hash['datetaken'].to_datetime
        if photo_hash["isprimary"].to_i == 1
          self.iconsmall   =  photo.url_icon
          self.iconlarge   =  photo.url_big
          self.main_photo  =  photo
        end
      end.save
    end
    self.created_at = photos.order('created_at').last.created_at

    if self.post
      self.post.created_at = self.created_at
      self.post.save
    end

    self.save!
  end

  #after_create :create_post
  def create_post
    content = %(<div class="collection">
                <p>
                <a href='#{Rails.application.routes.url_helpers.seo_album_path(self.collection, self)}' target="" rel=""><img alt="" src='#{self.main_photo.try(:url_small).presence || iconsmall}' class="center-block img-thumbnail"></a>
                <a href='#{Rails.application.routes.url_helpers.seo_album_path(self.collection, self)}' target="" rel="">Hier gehts zu den Bildern</a>
                </p>
                </div>)
    Post.create(:title => " Neue Bilder: #{name}", :content => content, :created_at => self.created_at, :album_id => self.id )
  end


end
