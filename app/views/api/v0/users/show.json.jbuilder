json.user do
  json.id @user.id
  json.slug @user.slug
  json.profile_url list_url(@user)
end
