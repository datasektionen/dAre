class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :headline
      t.string :content
      t.integer :administrator_id

      t.timestamps
    end
    add_index :posts, [:administrator_id, :created_at]
  end
end
