json.list do
  json.id @list.id
  json.name @list.name
  json.products_count @list.products_count
  json.item do
    json.user do
      json.id @item.user_id
    end
    json.product do
      json.partial! "api/v0/products/product", product: @product
    end
    json.rank @item.rank
  end
end
