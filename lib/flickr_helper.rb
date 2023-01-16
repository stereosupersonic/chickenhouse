# require "flickraw"

# https://github.com/hanklords/flickraw
module FlickrHelper
  FlickRaw.api_key = ENV["FLICKR_API_KEY"]
  FlickRaw.shared_secret = ENV["FLICKR_SHARED_SECRET"]

  def flickr_access
    @flickr_access ||= login
  end

  def login
    begin
      flickr.access_token = ENV["FLICKR_OAUTH_TOKEN"]
      flickr.access_secret = ENV["FLICKR_OAUTH_TOKEN_SECRET"]

      @login ||= flickr.test.login
      Rails.logger.info "Flickr  authenticated as #{@login.username}"
    rescue FlickRaw::FailedResponse => e
      raise "Authentication failed : #{e.msg}"
    end
    flickr
  end
end
