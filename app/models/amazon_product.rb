class AmazonProduct < Product
  def store_name
    "Amazon"
  end

  def api_product
    @api_product ||= Amazon::ProductAPI.new(Amazon::Ecs.item_lookup(sku, {:response_group => 'Medium'}).items.first)
  end
end
