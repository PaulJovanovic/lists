class Amazon::ProductAPI
  def initialize(product)
    attributes = product.get_element('ItemAttributes')
    @product_sku = product.get('ASIN')
    @product_name = attributes.get("Title")
    @product_manufacturer = attributes.get("Author") || attributes.get("Brand") || attributes.get("Manufacturer")
    @product_price_cents = (product.get_element("OfferSummary/LowestNewPrice/Amount").try(:get_array).try(:first) || product.get_element("OfferSummary/LowestUsedPrice/Amount").try(:get_array).try(:first)).to_i
    @product_url = product.get_element("DetailPageURL").get_array.first
    @product_image_url = product.get_hash('LargeImage').try(:[], "URL")
    @product_category_name = get_category_name(product)
    @product_subcategory_names = get_subcategory_names(product)
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

  def price
    Money.new(price_cents, "USD")
  end

  def url
    @product_url
  end

  def image_url
    @product_image_url
  end

  def category_name
    @product_category_name
  end

  def subcategory_names
    @product_subcategory_names
  end

  private

  def extract_category_names(product)
    @categories ||= product.get_element('BrowseNode').get_elements('Name').map{|element| element.get_array.last}
  end

  def get_category_name(product)
    extract_category_names(product).last
  end

  def get_subcategory_names(product)
    extract_category_names(product)[0..-3]
  end
end
