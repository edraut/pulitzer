class AddParentIdToPulitzerTag < ActiveRecord::Migration
  def change
    add_column :pulitzer_tags, :parent_id, :integer
    add_column :pulitzer_tags, :hierarchical, :boolean, null: false, default: false
    add_index :pulitzer_tags, :hierarchical
  end
end
