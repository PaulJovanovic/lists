class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :list_id
      t.integer :product_id
      t.integer :user_id
      t.integer :rank
      t.timestamps
    end

    add_index :list_items, [:list_id, :product_id], unique: true
  end
end
