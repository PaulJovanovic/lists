class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.integer :category_id
      t.string :name
      t.timestamps
    end

    add_index :subcategories, :name
    add_index :subcategories, [:category_id, :name], unique: true
  end
end
