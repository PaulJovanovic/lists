class ListItem < ActiveRecord::Base
  belongs_to :list, counter_cache: :products_count
  belongs_to :product
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy

  validates :user, :product, :list, presence: true

  after_create :set_rank
  after_create :score_creation
  after_create :add_product_category_to_list

  def add_product_category_to_list
    list.add_category(product.category)
  end

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
    new_rank = list.items_ordered_by_most_likes.index(self)
    ranks = [rank , new_rank].sort
    list.recalculate_ranks(ranks[0], ranks[1])
  end

  def likes_count_percent
    if list.likes_count > 0
      likes_count.to_f / list.likes_count
    else
      0.0
    end
  end

  def score!(actionable, weight)
    unless actionable.class.name == "Like" && actionable.user_id == user_id
      user.score!(actionable, weight)
    end
    list.score!(actionable, weight)
  end

  private

  def score_creation
    score!(self, 5)
  end

  def set_rank
    update_column(:rank, list.items.count - 1)
  end
end
