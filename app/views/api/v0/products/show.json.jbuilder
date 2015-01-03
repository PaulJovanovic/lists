json.product do
  json.partial! "api/v0/products/product", product: @product
end
