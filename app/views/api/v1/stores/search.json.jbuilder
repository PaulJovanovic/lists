json.products do
  json.array! @products.each do |product|
    json.sku product.sku
    json.name product.name
    json.manufacturer product.manufacturer
    json.price product.price.to_s
    json.url product.url
    json.image_url product.image_url
  end
end
