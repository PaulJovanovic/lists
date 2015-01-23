class AddScoresToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :total_score, :integer, default: 0
    add_column :categories, :current_score, :integer, default: 0
  end
end
