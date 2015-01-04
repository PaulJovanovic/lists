class AmazonProduct < Product
  def store_name
    "Amazon"
  end

  def api_product
    @api_product ||= Amazon::Ecs.item_lookup(sku, {:response_group => 'Medium'}).items.first
  end

  def api_product_attributes
    api_product.get_element('ItemAttributes')
  end

  def api_product_name
    api_product_attributes.get("Title")
  end

  def api_product_manufacturer
    api_product_attributes.get("Brand")
  end

  def api_product_price_cents
    api_product_attributes.get("ListPrice/Amount").to_i
  end

  def api_product_url
    api_product.get_element("DetailPageURL").get_array.first
  end

  def api_product_image_url
    api_product.get_hash('LargeImage')["URL"]
  end
end
