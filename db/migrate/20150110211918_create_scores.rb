class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :scorable_type
      t.integer :scorable_id
      t.string :actionable_type
      t.integer :actionable_id
      t.integer :weight
      t.timestamps
    end

    add_column :users, :current_score, :integer
    add_column :users, :total_score, :integer
    add_column :lists, :current_score, :integer
    add_column :lists, :total_score, :integer
  end
end
