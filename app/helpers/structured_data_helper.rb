module StructuredDataHelper
  def json_ld(data)
    tag.script(data.to_json.html_safe, type: "application/ld+json")
  end

  def organization_structured_data
    {
      "@context" => "https://schema.org",
      "@type" => "SportsClub",
      "name" => "Henaheisl e.V.",
      "alternateName" => "FC Bayern Fanclub Wartenberg",
      "description" => "Offizieller FC Bayern Fanclub aus Wartenberg, gegründet 1991.",
      "url" => root_url,
      "logo" => image_url("banner_v3.png"),
      "foundingDate" => "1991-07-20",
      "address" => {
        "@type" => "PostalAddress",
        "addressLocality" => "Wartenberg",
        "addressRegion" => "Bayern",
        "addressCountry" => "DE"
      },
      "sameAs" => [
        "https://www.facebook.com/henaheisl",
        "https://www.instagram.com/henaheisl"
      ],
      "email" => "info@henaheisl.de",
      "memberOf" => {
        "@type" => "SportsOrganization",
        "name" => "FC Bayern München"
      }
    }
  end

  def event_structured_data(event)
    data = {
      "@context" => "https://schema.org",
      "@type" => "Event",
      "name" => event.title,
      "startDate" => event.start_date.iso8601,
      "description" => event.content.truncate(300),
      "url" => event_url(event),
      "organizer" => {
        "@type" => "Organization",
        "name" => "Henaheisl e.V.",
        "url" => root_url
      },
      "eventAttendanceMode" => "https://schema.org/OfflineEventAttendanceMode",
      "eventStatus" => "https://schema.org/EventScheduled"
    }

    data["endDate"] = event.end_date.iso8601 if event.end_date.present?

    if event.location.present?
      data["location"] = {
        "@type" => "Place",
        "name" => event.location,
        "address" => {
          "@type" => "PostalAddress",
          "addressLocality" => "Wartenberg",
          "addressRegion" => "Bayern",
          "addressCountry" => "DE"
        }
      }
    end

    data
  end

  def blog_posting_structured_data(post)
    {
      "@context" => "https://schema.org",
      "@type" => "BlogPosting",
      "headline" => post.title,
      "description" => PostPresenter.new(post).meta_description,
      "url" => post_url(post),
      "datePublished" => post.created_at.iso8601,
      "dateModified" => post.updated_at.iso8601,
      "author" => {
        "@type" => "Organization",
        "name" => "Henaheisl e.V."
      },
      "publisher" => {
        "@type" => "Organization",
        "name" => "Henaheisl e.V.",
        "logo" => {
          "@type" => "ImageObject",
          "url" => image_url("banner_v3.png")
        }
      }
    }
  end

  def breadcrumb_structured_data(items)
    {
      "@context" => "https://schema.org",
      "@type" => "BreadcrumbList",
      "itemListElement" => items.each_with_index.map do |item, index|
        element = {
          "@type" => "ListItem",
          "position" => index + 1,
          "name" => item[:name]
        }
        element["item"] = item[:url] if item[:url]
        element
      end
    }
  end
end
