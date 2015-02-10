json.comment do
  json.id @comment.id
  json.commentable_type @comment.commentable_type
  json.commentable_id @comment.commentable_id
  json.text sanitize(simple_format(@comment.text), tags: %w(br) ).strip
  json.created_at @comment.created_at.strftime("%m/%d/%y")
  json.user do
    json.id @comment.user.id
    json.username @comment.user.username
    json.profile_url user_url(@comment.user, subdomain: nil)
    json.profile_image @comment.user.profile_image
  end
end
