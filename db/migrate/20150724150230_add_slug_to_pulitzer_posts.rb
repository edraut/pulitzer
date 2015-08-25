class AddSlugToPulitzerPosts < ActiveRecord::Migration
  def change
    add_column :pulitzer_posts, :slug, :string
    add_index :pulitzer_posts, :slug, unique: true
  end
end
