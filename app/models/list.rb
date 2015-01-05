class List < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :items, class_name: "ListItem", dependent: :destroy
  has_many :products, through: :items

  validates :name, presence: true

  def add_product(product, user)
    items.create(product: product, user: user)
  end

  def recalculate_ranks(start, finish)
    items[start..finish].each do |item|
      item.update_column(:rank, items.index(item))
    end
  end

  def minimum_price
    Money.new(products.minimum("price_cents"))
  end

  def maximum_price
    Money.new(products.maximum("price_cents"))
  end
end
