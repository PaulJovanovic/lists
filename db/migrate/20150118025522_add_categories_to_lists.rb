class AddCategoriesToLists < ActiveRecord::Migration
  def change
    create_table :categories_lists do |t|
      t.integer :category_id
      t.integer :list_id
    end
  end
end
