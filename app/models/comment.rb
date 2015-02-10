class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :text, :user, :commentable, presence: true

  after_create :increment_comments_count
  after_create :score
  after_destroy :decrement_comments_count

  private

  def score
    commentable.score!(commentable.list, self, 2)
    unless commentable.user == user
      commentable.user.score!(commentable.list, self, 2)
    end
  end

  def decrement_comments_count
    commentable_type.constantize.decrement_counter(:comments_count, commentable_id)
  end

  def increment_comments_count
    commentable_type.constantize.increment_counter(:comments_count, commentable_id)
  end
end
