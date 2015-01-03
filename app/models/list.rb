class List < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :items, class_name: "ListItem", dependent: :destroy
  has_many :products, through: :list_items

  validates :name, presence: true

  def add_product(product, user)
    items.create(product: product, user: user)
  end
end
