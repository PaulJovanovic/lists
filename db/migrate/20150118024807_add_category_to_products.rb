class AddCategoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category_id, :integer

    create_table :products_subcategories do |t|
      t.integer :product_id
      t.integer :subcategory_id
    end
  end
end
