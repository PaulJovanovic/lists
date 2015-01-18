class AmazonProduct < Product
  def store_name
    "Amazon"
  end

  def api_product
    @api_product ||= Amazon::ProductAPI.new(Amazon::Ecs.item_lookup(sku, {:response_group => 'Large'}).items.first)
  end
end
