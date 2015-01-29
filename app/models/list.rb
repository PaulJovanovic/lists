class List < ActiveRecord::Base
  extend FriendlyId
  include Scoring
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :user
  has_many :items, class_name: "ListItem", dependent: :destroy
  has_many :products, through: :items
  has_many :scores, as: :scorable, dependent: :destroy
  has_and_belongs_to_many :categories

  scope :most_active, -> { where("products_count > 0").order(current_score: :desc, products_count: :desc, created_at: :asc) }
  scope :most_popular, -> { where("products_count > 0").order(total_score: :desc, products_count: :desc, created_at: :asc) }
  scope :most_products, -> { where("products_count > 0").order(products_count: :desc, created_at: :asc) }
  scope :needs_help, -> { where(products_count: 0).order(:created_at) }

  scope :most_active_by_category, lambda { |category_name|
    joins(:categories).
    where('categories.id = categories_lists.category_id
           AND categories_lists.list_id = lists.id
           AND categories.name = ?', category_name).
    order(current_score: :desc, products_count: :desc, created_at: :asc)
  }
  scope :most_popular_by_category, lambda { |category_name|
    joins(:categories).
    where('categories.id = categories_lists.category_id
           AND categories_lists.list_id = lists.id
           AND categories.name = ?', category_name).
    order(total_score: :desc, products_count: :desc, created_at: :asc)
  }
  scope :most_products_by_category, lambda { |category_name|
    joins(:categories).
    where('categories.id = categories_lists.category_id
           AND categories_lists.list_id = lists.id
           AND categories.name = ?', category_name).
    order(products_count: :desc, created_at: :asc)
  }

  validates :name, :user, presence: true

  def self.scope(scope, params = nil)
    if params.present?
      List.send("#{scope}_by_category", params)
    else
      List.send(scope)
    end
  end

  def self.from_amazon_listmania_url(url)
    doc = Nokogiri::HTML(open(url))
    user = User.first
    list = List.create(name: doc.css("h1.largeTitle")[0].content.titleize, user: user)
    doc.css("input[name^='asin']").each do |input|
      sku = input["value"]
      begin
        product = Product.where(type: "AmazonProduct", sku: sku).last || Product.create(type: "AmazonProduct", sku: sku)
        list.add_product(product, user)
      rescue
        puts "#{sku} failed"
      end
    end
  end

  def add_category(category)
    if !category_ids.include?(category.id)
      categories << category
    end
    save
  end

  def add_product(product, user)
    item = items.where(product_id: product.id).last || items.create(product: product, user: user)
    calculate_minimum_price
    calculate_maximum_price
    item
  end

  def calculate_minimum_price
    update_column(:minimum_price_cents, products.minimum("price_cents"))
  end

  def calculate_maximum_price
    update_column(:maximum_price_cents, products.maximum("price_cents"))
  end

  def contributors_count
    items.select("DISTINCT user_id").count
  end

  def default_image(category=nil)
    if category
      items_ordered_by_rank.includes(:product).where(products: { category_id: category.id }).first.product.image.url(:profile)
    else
      items_ordered_by_rank.first.try(:product).try(:image).try(:url, :profile) || "http://placehold.it/300x300"
    end
  end

  def items_ordered_by_rank
    items.order(rank: :asc, created_at: :asc)
  end

  def items_ordered_by_most_likes
    items.order(likes_count: :desc, created_at: :asc)
  end

  def likes_count
    items.sum(:likes_count)
  end

  def minimum_price
    Money.new(minimum_price_cents)
  end

  def maximum_price
    Money.new(maximum_price_cents)
  end

  def maximum_likes_count
    items.maximum(:likes_count)
  end

  def recalculate_ranks(start, finish)
    ordered_items = items_ordered_by_most_likes
    ordered_items[start..finish].each do |item|
      item.update_column(:rank, ordered_items.index(item))
    end
  end
end
