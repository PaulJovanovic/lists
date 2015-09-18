json.id product.id
json.type product.type
json.name product.name
json.slug product.slug
json.manufacturer product.manufacturer
json.sku product.sku
json.url product.url
json.price product.price.to_s
json.images do
  json.thumbnail product.image.url(:thumbnail)
  json.profile product.image.url(:profile)
end
