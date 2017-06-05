class AddLayoutToContentElements < ActiveRecord::Migration[5.0]
  def change
    remove_column :pulitzer_content_elements, :kind, :integer
    add_column :pulitzer_content_elements, :layout_id, :integer
    add_column :pulitzer_content_elements, :custom_option_id, :integer
  end
end
