json.id list.id
json.name list.name
json.slug list.slug
json.url list_url(list, subdomain: "")
json.image list.default_image
json.minimum_price list.minimum_price.to_s
json.maximum_price list.maximum_price.to_s
json.products_count list.products_count
json.list_item_ids list.items.pluck(:id)
