class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user
  has_many :scores, as: :actionable, dependent: :destroy

  validates :likable, :user, presence: true

  after_create :increment_likes_count
  after_create :score
  after_destroy :decrement_likes_count

  private

  def score
    likable.score!(likable.list, self, 1)
    unless likable.user == user
      likable.user.score!(likable.list, self, 1)
    end
  end

  def decrement_likes_count
    likable_type.constantize.decrement_counter(:likes_count, likable_id)
    likable.unliked
  end

  def increment_likes_count
    likable_type.constantize.increment_counter(:likes_count, likable_id)
    likable.liked
  end

end
