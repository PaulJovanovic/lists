json.id list_item.id
json.likes do
  json.array! list_item.likes.includes(:user).each do |like|
    json.user do
      json.id like.user.id
      json.username like.user.username
      json.total_score like.user.total_score.to_i
    end
  end
end
