json.id comment.id
json.user comment.user_id
json.text sanitize(simple_format(comment.text), tags: %w(br) ).strip
json.createdAt comment.created_at.iso8601
json.updatedAt comment.updated_at.iso8601
