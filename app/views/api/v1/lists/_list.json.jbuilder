json.id list.id
json.name list.name
json.slug list.slug
json.image list.default_image
json.minimumPrice list.minimum_price.to_s
json.maximumPrice list.maximum_price.to_s
json.productsCount list.products_count
json.listItems list.items.pluck(:id)
