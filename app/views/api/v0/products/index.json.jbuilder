json.products do
  json.array! @products.each do |product|
    json.partial! "api/v0/products/product", product: product
  end
end
