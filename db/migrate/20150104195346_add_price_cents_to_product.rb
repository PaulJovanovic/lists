class AddPriceCentsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :price_cents, :integer, default: 0
  end
end
