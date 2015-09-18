json.product do
  json.partial! "api/v1/products/product", product: @product
end
