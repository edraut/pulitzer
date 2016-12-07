class RemoveTitleFromContentElements < ActiveRecord::Migration
  def change
    remove_column :pulitzer_content_elements, :title
  end
end
