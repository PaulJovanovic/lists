json.id list_item.id
json.list list_item.list_id
json.product list_item.product_id
json.user list_item.user_id
json.comments list_item.comments.order(:created_at).pluck(&:id)
json.rank list_item.rank
json.currentScore list_item.current_score
json.totalScore list_item.total_score
