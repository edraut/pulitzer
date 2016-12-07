class AddPostTypeContentElementAttributesToContentElements < ActiveRecord::Migration
  def up
    add_column :pulitzer_content_elements, :text_editor, :string
    add_column :pulitzer_content_elements, :height, :integer, default: 100
    add_column :pulitzer_content_elements, :width, :integer, default: 100
    add_column :pulitzer_content_elements, :sort_order, :integer
    Pulitzer::ContentElement.reset_column_information
    Pulitzer::ContentElement.find_each do |ce|
      if ptce = ce.post_type_content_element_type
        ce.update(text_editor: ptce.text_editor, height: ptce.height, width: ptce.width)
      end
    end
  end

  def down
    remove_column :pulitzer_content_elements, :text_editor
    remove_column :pulitzer_content_elements, :height
    remove_column :pulitzer_content_elements, :width
    remove_column :pulitzer_content_elements, :sort_order
  end
end
