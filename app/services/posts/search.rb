module Posts
  class Search < BaseService
    DOCUMENT = "setweight(to_tsvector('german', COALESCE(posts.title, '')), 'A') || " \
               "setweight(to_tsvector('german', COALESCE(action_text_rich_texts.body::text, '')), 'B')".freeze
    TS_QUERY = "plainto_tsquery('german', :query)".freeze

    attr_accessor :query, :scope

    def call
      scope
        .left_joins(:rich_text_content)
        .where("#{DOCUMENT} @@ #{TS_QUERY}", query: query)
        .order(Arel.sql(Post.sanitize_sql_array([ "ts_rank(#{DOCUMENT}, #{TS_QUERY}) DESC", { query: query } ])))
    end
  end
end
