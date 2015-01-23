class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_and_belongs_to_many :lists
  has_many :products
  has_many :subcategories

  def calculate_scores
    calculate_current_score
    calculate_total_score
  end

  def calculate_current_score
    update_column(:current_score, lists.sum(:current_score))
  end

  def calculate_total_score
    update_column(:total_score, lists.sum(:total_score))
  end
end
