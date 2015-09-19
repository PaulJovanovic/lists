json.id user.id
json.slug user.slug
json.username user.username
json.images do
  json.thumbnail user.profile_image
  json.profile user.profile_image(300)
end
