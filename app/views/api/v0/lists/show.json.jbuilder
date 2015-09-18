json.list do
  json.partial! "api/v0/lists/list", list: @list
end
json.list_items do
  json.array! @list.items.each do |item|
    json.partial! "api/v0/list_items/list_item", list_item: item
  end
end
