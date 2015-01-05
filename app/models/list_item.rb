class ListItem < ActiveRecord::Base
  belongs_to :list, counter_cache: :products_count
  belongs_to :product
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy

  validates :user, :product, :list, presence: true

  after_create :set_rank

  default_scope { order(likes_count: :desc, created_at: :asc) }

  def display_rank
    rank + 1
  end

  def liked
    recalculate_rank
  end

  def unliked
    recalculate_rank
  end

  def recalculate_rank
    new_rank = list.items.index(self)
    ranks = [rank , new_rank].sort
    list.recalculate_ranks(ranks[0], ranks[1])
  end

  private

  def set_rank
    update_column(:rank, list.items.count - 1)
  end
end
