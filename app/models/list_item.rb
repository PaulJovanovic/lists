class ListItem < ActiveRecord::Base
  belongs_to :list, counter_cache: :products_count
  belongs_to :product
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy

  validates :user, :product, :list, presence: true

  after_create :set_rank

  default_scope { order(likes_count: :desc, created_at: :asc) }

  private

  def set_rank
    update_column(:rank, list.items.count)
  end
end
