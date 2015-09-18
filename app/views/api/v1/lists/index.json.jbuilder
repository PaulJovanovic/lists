json.lists do
  json.array! @lists.each do |list|
    json.partial! "api/v1/lists/list", list: list
  end
end
