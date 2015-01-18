class Amazon::QueryAPI
  def initialize(q, page)
    @results = Amazon::Ecs.item_search(q, {:response_group => 'Large', :search_index => 'All'})
  end

  def error?
    @results.has_error?
  end

  def error
    @results.error
  end

  def item_page
    @results.item_page
  end

  def items
    @results.items
  end

  def success?
    @results.is_valid_request?
  end

  def total_pages
    @results.total_pages
  end

  def total_results
    @results.total_results
  end
end
