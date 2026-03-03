xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc root_url
    xml.changefreq "daily"
    xml.priority "1.0"
  end

  xml.url do
    xml.loc about_url
    xml.changefreq "monthly"
    xml.priority "0.8"
  end

  xml.url do
    xml.loc events_url
    xml.changefreq "weekly"
    xml.priority "0.8"
  end

  xml.url do
    xml.loc posts_url
    xml.changefreq "daily"
    xml.priority "0.8"
  end

  xml.url do
    xml.loc impressum_url
    xml.changefreq "yearly"
    xml.priority "0.3"
  end

  @posts.each do |post|
    xml.url do
      xml.loc post_url(post)
      xml.lastmod post.updated_at.iso8601
      xml.changefreq "monthly"
      xml.priority "0.6"
    end
  end

  @events.each do |event|
    xml.url do
      xml.loc event_url(event)
      xml.lastmod event.updated_at.iso8601
      xml.changefreq "monthly"
      xml.priority "0.6"
    end
  end
end
