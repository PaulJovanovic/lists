class AddScoresToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :total_score, :integer, default: 0
    add_column :list_items, :current_score, :integer, default: 0
  end
end
