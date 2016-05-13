# This migration comes from pulitzer (originally 20160511201527)
class AddParentIdToPulitzerTag < ActiveRecord::Migration
  def change
    add_column :pulitzer_tags, :parent_id, :integer
    add_column :pulitzer_tags, :hierarchical, :boolean, null: false, default: false
    add_index :pulitzer_tags, :hierarchical
  end
end
