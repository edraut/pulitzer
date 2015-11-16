# This migration comes from pulitzer (originally 20151116162508)
class ChangeTemplateToPulitzerPostTypes < ActiveRecord::Migration
  def up
    rename_column :pulitzer_post_types, :template, :kind
    change_column :pulitzer_post_types, :kind, :integer, default: 0
  end

  def down
    remove_column :pulitzer_post_types, :kind
    add_column :pulitzer_post_types, :template, :boolean
  end
end
