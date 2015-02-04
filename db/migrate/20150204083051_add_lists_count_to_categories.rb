class AddListsCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :lists_count, :integer, default: 0
  end
end
