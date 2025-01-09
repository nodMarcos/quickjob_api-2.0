class Search < ApplicationRecord

  attr_accessor :query, :where_filters, :sort_filters, :page, :per_page,
                :total_count, :total_pages, :next_page, :prev_page

  def initialize(atts)
    atts ||= {}
    super(atts)

    @query = '*'
    @where_filters = {}
    @sort_filters ||= { _score: :desc }
    @page = atts[:page] || 1
    @per_page = atts[:per_page] || 25
  end

  def results
    @results ||= model_class.search(
      query,
      fields: model_class.scored_fields,
      select: model_class.search_select,
      where: where_filters,
      order: sort_filters,
      page: page,
      per_page: per_page,
    )
  end

  def raw_results
    @raw_results ||= results
      .response['hits']['hits']
      .map{ |h| h['_source'] }
    @total_count ||= results.response['hits']['total']['value']
    @total_pages = (total_count.to_f / per_page.to_f).ceil
    @prev_page = page.to_i > 1 ? page.to_i - 1 : nil
    @next_page = page.to_i < total_pages ? page.to_i + 1 : nil
    @raw_results
  end

  def to_a
    results.to_a
  end

  def each
    results.each
  end

  def total_count
    results.total_count
  end
end
