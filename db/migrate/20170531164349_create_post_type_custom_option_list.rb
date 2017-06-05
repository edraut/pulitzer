class CreatePostTypeCustomOptionList < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_post_type_content_element_type_custom_option_lists do |t|
      t.integer :post_type_content_element_type_id
      t.integer :custom_option_list_id
    end
  end
end
