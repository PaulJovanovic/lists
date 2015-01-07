class AmazonStore < Store
  def name
    "Amazon"
  end

  def search(q, page=1)
    (@queries[q] ||= {})[page] ||= Amazon::QueryAPI.new(q, page).items.map{|item| Amazon::ProductAPI.new(item) }
  end

  def url
    "http://www.amazon.com"
  end
end
