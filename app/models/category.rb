class Category < ActiveRecord::Base
  has_and_belongs_to_many :lists
  has_many :products
  has_many :subcategories

  default_scope { order(name: :asc) }
end
