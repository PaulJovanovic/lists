json.list do
  json.partial! "api/v1/lists/list", list: @list
end
json.list_items do
  json.array! @list.items.each do |item|
    json.partial! "api/v1/list_items/list_item", list_item: item
  end
end
json.products do
  json.array! @list.items.each do |item|
    json.partial! "api/v1/products/product", product: item.product
  end
end
