class AddSortToPostElements < ActiveRecord::Migration[5.0]
  def change
    add_column :pulitzer_post_type_content_element_types, :sort_order, :integer
    add_column :pulitzer_free_form_section_types, :sort_order, :integer
  end
end
