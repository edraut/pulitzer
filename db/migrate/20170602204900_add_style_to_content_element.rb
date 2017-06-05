class AddStyleToContentElement < ActiveRecord::Migration[5.0]
  def change
    rename_column :pulitzer_content_elements, :layout_id, :style_id
  end
end
