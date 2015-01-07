class Amazon::ProductAPI
  def initialize(product)
    attributes = product.get_element('ItemAttributes')
    @product_sku = product.get('ASIN')
    @product_name = attributes.get("Title")
    @product_manufacturer = attributes.get("Brand")
    @product_price_cents = product.get_element("OfferSummary/LowestNewPrice/Amount").try(:get_array).try(:first).to_i
    @product_url = product.get_element("DetailPageURL").get_array.first
    @product_image_url = product.get_hash('LargeImage').try(:[], "URL")
  end

  def sku
    @product_sku
  end

  def name
    @product_name
  end

  def manufacturer
    @product_manufacturer
  end

  def price_cents
    @product_price_cents
  end

  def url
    @product_url
  end

  def image_url
    @product_image_url
  end
end
