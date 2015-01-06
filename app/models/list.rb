class List < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :items, class_name: "ListItem", dependent: :destroy
  has_many :products, through: :items

  validates :name, presence: true

  def add_product(product, user)
    items.create(product: product, user: user)
  end

  def contributors_count
    items.group(:user_id).count.count
  end

  def likes_count
    items.sum(:likes_count)
  end

  def minimum_price
    Money.new(products.minimum("price_cents"))
  end

  def maximum_price
    Money.new(products.maximum("price_cents"))
  end

  def recalculate_ranks(start, finish)
    items[start..finish].each do |item|
      item.update_column(:rank, items.index(item))
    end
  end
end
