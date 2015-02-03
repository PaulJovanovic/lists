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

  def most_active_lists
    lists.most_active
  end

  def homepage_lists
    active_lists = most_active_lists.limit(8)
    active_lists.take(number_of_lists_to_display(active_lists.count))
  end

  private

  def number_of_lists_to_display(lists_count)
    case lists_count
    when 1
      1
    when 2, 3
      2
    when 4, 5, 6, 7
      4
    else
      8
    end
  end
end
