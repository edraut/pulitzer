class ChangeTemplateToPulitzerPostTypes < ActiveRecord::Migration
  def up
    remove_column :pulitzer_post_types, :template
    add_column :pulitzer_post_types, :kind, :integer, default: 0
  end

  def down
    remove_column :pulitzer_post_types, :kind
    add_column :pulitzer_post_types, :template, :boolean
  end
end
