json.lists do
  json.array! @lists.each do |list|
    json.partial! "api/v0/lists/list", list: list
  end
end
