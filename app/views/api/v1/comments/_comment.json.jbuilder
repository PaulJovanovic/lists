json.id comment.id
json.user comment.user_id
json.text sanitize(simple_format(comment.text), tags: %w(br) ).strip
json.created_at comment.created_at.strftime("%m/%d/%y")
json.updated_at comment.updated_at.strftime("%m/%d/%y")
