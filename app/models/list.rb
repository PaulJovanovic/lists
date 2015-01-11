class List < ActiveRecord::Base
  extend FriendlyId
  include Scoring
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :user
  has_many :items, class_name: "ListItem", dependent: :destroy
  has_many :products, through: :items
  has_many :scores, as: :scorable, dependent: :destroy

  scope :most_active, -> { where("products_count > 0").order(current_score: :desc, products_count: :desc, created_at: :asc) }
  scope :most_popular, -> { where("products_count > 0").order(total_score: :desc, products_count: :desc, created_at: :asc) }
  scope :most_products, -> { where("products_count > 0").order(products_count: :desc, created_at: :asc) }
  scope :needs_help, -> { where(products_count: 0).order(:created_at) }

  validates :name, :user, presence: true

  def self.scope(scope)
    scope ||= "all"
    List.send(scope)
  end

  def add_product(product, user)
    items.create(product: product, user: user)
  end

  def contributors_count
    items.select("DISTINCT user_id").count
  end

  def default_image
    items.first.try(:product).try(:image).try(:url, :profile) || "http://placehold.it/300x300"
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
