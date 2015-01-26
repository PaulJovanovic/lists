class AddPricesToLists < ActiveRecord::Migration
  def change
    add_column :lists, :minimum_price_cents, :integer
    add_column :lists, :maximum_price_cents, :integer
  end
end
