json.id product.id
json.type product.type
json.manufacturer product.manufacturer
json.sku product.sku
json.url product.url
json.images do
  json.thumbnail product.image.url(:thumbnail)
  json.medium product.image.url(:thumbnail)
end
