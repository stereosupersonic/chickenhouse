module Posts
  class Search < BaseService
    attr_accessor :query, :scope

    validates :query, presence: true

    def initialize(args = nil)
      super()
      @query = args&.dig(:query)
      @scope = args&.dig(:scope) || Post.all
    end

    def call
      if query.blank?
        set_result(Post.none)
        return self
      end

      set_result(
        scope
          .left_joins(:rich_text_content)
          .where(
            "to_tsvector('german', COALESCE(posts.title, '') || ' ' || COALESCE(action_text_rich_texts.body::text, '')) @@ plainto_tsquery('german', ?)",
            query
          )
          .order(
            Arel.sql(Post.sanitize_sql_array([
              "ts_rank(" \
              "setweight(to_tsvector('german', COALESCE(posts.title, '')), 'A') || " \
              "setweight(to_tsvector('german', COALESCE(action_text_rich_texts.body::text, '')), 'B'), " \
              "plainto_tsquery('german', ?)" \
              ") DESC",
              query
            ]))
          )
      )

      self
    end
  end
end
