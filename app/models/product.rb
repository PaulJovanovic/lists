class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :category
  has_one :image, as: :assetable, class_name: "Image", dependent: :destroy
  has_many :list_items, dependent: :destroy
  has_many :lists, through: :list_items
  has_many :comments, through: :list_items
  has_and_belongs_to_many :subcategories

  before_create :fetch_api_attributes

  validates :sku, presence: true, uniqueness: true

  def price
    Money.new(price_cents, "USD")
  end

  def set_category(category_name)
    self.category = Category.where(name: category_name).last || Category.create(name: category_name)
  end

  def set_subcategories(subcategory_names)
    subcategory_names.each do |subcategory_name|
      self.subcategories << (category.subcategories.where(category: category, name: subcategory_name).last || category.subcategories.create(category: category, name: subcategory_name))
    end
  end

  def sync_category_and_subcategories
    set_category(api_product.category_name)
    set_subcategories(api_product.subcategory_names)
    save
  end

  def sync_price
    update_column(:price_cents, api_product.price_cents)
  end

  private

  def fetch_api_attributes
    self.name = api_product.name
    self.manufacturer = api_product.manufacturer
    self.price_cents = api_product.price_cents
    self.url = api_product.url
    build_image
    image.attachment_from_url(api_product.image_url)
    set_category(api_product.category_name)
    set_subcategories(api_product.subcategory_names)
  end
end
