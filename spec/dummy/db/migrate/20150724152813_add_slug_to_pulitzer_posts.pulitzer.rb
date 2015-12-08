# This migration comes from pulitzer (originally 20150724150230)
class AddSlugToPulitzerPosts < ActiveRecord::Migration
  def change
    add_column :pulitzer_posts, :slug, :string
    add_index :pulitzer_posts, :slug, unique: true
  end
end
