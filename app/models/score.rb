class Score < ActiveRecord::Base
  # example:
  # User likes list item
  # user gets 1 point
  # scorable_type: "User", scorable_id: 1, actionable_type: "Like", actionable_id: 2, weight: 1
  belongs_to :scorable, polymorphic: true
  belongs_to :actionable, polymorphic: true

  validates :scorable, :actionable, :weight, presence: true
end
