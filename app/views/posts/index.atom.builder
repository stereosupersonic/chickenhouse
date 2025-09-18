xml.instruct!(:xml, version: "1.0")
xml.feed("xml:lang" => "de-DE", :xmlns => "http://www.w3.org/2005/Atom") do |feed|
  feed.title("Henaheisl Blog")
  feed.id("tag:#{request.host},#{Time.zone.now.year}:/posts")
  feed.link(href: "http://#{request.host_with_port}/", rel: "alternate", type: "text/html")
  feed.link(href: "#{request.protocol}#{request.host_with_port}#{request.fullpath}", rel: "self", type: "application/atom+xml")
  feed.updated(@posts.first.updated_at.iso8601) if @posts.first
  @posts.each do |post|
    post_presenter = PostPresenter.new(post)
    feed.entry do |entry|
      entry.id("tag:#{request.host},#{post.updated_at.year}:Post/#{post.id}")
      entry.published(post_presenter.created_at.iso8601)
      entry.updated(post_presenter.updated_at.iso8601)
      entry.link(href: post_url(post_presenter), type: "text/html", rel: "alternate")
      entry.title(h(post_presenter.title))
      entry.content(type: "html") do
        entry.cdata!(post_presenter.html_content.to_s.html_safe)
      end
      entry.author do |author|
        author.name(post_presenter.author_name)
      end
    end
  end
end
