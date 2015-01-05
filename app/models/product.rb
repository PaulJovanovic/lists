class Product < ActiveRecord::Base
  has_one :image, :as => :assetable, :class_name => "ProductImage", :dependent => :destroy
  has_many :list_items, dependent: :destroy
  has_many :lists, through: :list_items

  before_create :fetch_api_attributes

  validates :sku, presence: true, uniqueness: true

  def price
    Money.new(price_cents, "USD")
  end

  def sync_price
    update_column(:price_cents, api_product_price_cents)
  end

  private

  def fetch_api_attributes
    self.name = api_product_name
    self.manufacturer = api_product_manufacturer
    self.price_cents = api_product_price_cents
    self.url = api_product_url
    build_image
    image.attachment_from_url(api_product_image_url)
  end
end
