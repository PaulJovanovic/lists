json.list do
  json.id @list.id
  json.slug @list.slug
  json.items do
    json.array! @list.items.includes(product: :image).each do |item|
      json.id item.id
      json.rank item.rank
      json.product do
        json.partial! "api/v0/products/product", product: item.product
      end
      json.user_id item.user_id
      json.likes_count item.likes_count
    end
  end
end
