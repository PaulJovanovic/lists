json.like do
  json.id @like.id
  json.user_id @like.user_id
  json.likable do
    json.id @like.likable_id
    json.type @like.likable_type
    json.likes_count @like.likable.likes_count
  end
end
