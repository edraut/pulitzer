class AddPartialToContentElement < ActiveRecord::Migration
  def change
    add_column :pulitzer_content_elements, :partial_id, :integer
  end
end
