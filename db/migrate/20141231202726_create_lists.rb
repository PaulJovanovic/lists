class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.boolean :active, default: false
      t.string :name
      t.integer :products_count, default: 0
      t.timestamps
    end
  end
end
