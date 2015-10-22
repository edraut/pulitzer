# This migration comes from pulitzer (originally 20151021222012)
class AddTextEditorToPulitzerPostTypeContentElementType < ActiveRecord::Migration
  def change
    add_column :pulitzer_post_type_content_element_types, :text_editor_id, :integer
    # Default index name is too long, so defined a name for it
    add_index :pulitzer_post_type_content_element_types, :text_editor_id, name: 'pulitzer_post_type_ce_text_editor_id'
  end
end
