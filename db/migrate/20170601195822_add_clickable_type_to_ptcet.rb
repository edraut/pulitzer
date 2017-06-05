class AddClickableTypeToPtcet < ActiveRecord::Migration[5.0]
  def change
    add_column :pulitzer_post_type_content_element_types, :clickable_kind, :string, default: 'any', null: false
  end
end
