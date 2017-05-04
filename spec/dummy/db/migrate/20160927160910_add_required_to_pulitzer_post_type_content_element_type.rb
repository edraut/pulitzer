class AddRequiredToPulitzerPostTypeContentElementType < ActiveRecord::Migration
  def change
    add_column :pulitzer_post_type_content_element_types, :required, :boolean, default: :false
  end
end
