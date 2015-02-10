class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.integer :user_id
      t.text :text
      t.timestamps
    end

    add_column :list_items, :comments_count, :integer, default: 0

    add_index :comments, :user_id
    add_index :comments, [:commentable_type, :commentable_id]
    add_index :comments, [:commentable_type, :commentable_id, :user_id], name: "index_comments_on_commentable_and_user_id"
  end
end
