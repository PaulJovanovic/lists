class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :type
      t.string :name
      t.string :manufacturer
      t.string :sku
      t.string :url
      t.timestamps
    end

    add_index :products, [:type, :sku], unique: true
  end
end
