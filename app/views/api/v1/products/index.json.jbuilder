json.products do
  json.array! @products.each do |product|
    json.partial! "api/v1/products/product", product: product
  end
end
