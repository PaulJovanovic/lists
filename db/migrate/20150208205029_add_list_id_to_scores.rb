class AddListIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :list_id, :integer
  end
end
