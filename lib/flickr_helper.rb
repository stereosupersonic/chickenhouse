require 'flickraw'

module FlickrHelper

  def flickr_access

    config = {
      :api_key            => ENV["FLICKR_API_KEY"],
      :shared_secret      => ENV["FLICKR_SHARED_SECRET"],
      :oauth_token        => ENV["FLICKR_OAUTH_TOKEN"],
      :oauth_token_secret => ENV["FLICKR_OAUTH_TOKEN_SECRET"]
    }
    puts config

    FlickRaw.api_key= config[:api_key]
    FlickRaw.shared_secret= config[:shared_secret]

    puts "FlickRaw.api_key: #{FlickRaw.api_key}"
    puts "FlickRaw.shared_secret: #{FlickRaw.shared_secret}"

    begin
      flickr.access_token = config[:oauth_token]
      flickr.access_secret = config[:oauth_token_secret]

      @login ||= flickr.test.login
      Rails.logger.info "Flickr  authenticated as #{@login.username}"
    rescue FlickRaw::FailedResponse => e
      raise "Authentication failed : #{e.msg}"
    end
    flickr
  end
end
