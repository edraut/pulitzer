# This migration comes from pulitzer (originally 20151113183344)
class AddPostTypeContentElementAttributesToContentElements < ActiveRecord::Migration
  def change
    add_column :pulitzer_content_elements, :text_editor, :string
    add_column :pulitzer_content_elements, :height, :integer, default: 100
    add_column :pulitzer_content_elements, :width, :integer, default: 100
    add_column :pulitzer_content_elements, :sort_order, :integer
    Pulitzer::ContentElement.reset_column_information
    Pulitzer::PostTypeContentElementType
  end
end
