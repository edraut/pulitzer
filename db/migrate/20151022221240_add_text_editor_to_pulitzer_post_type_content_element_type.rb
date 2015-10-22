class AddTextEditorToPulitzerPostTypeContentElementType < ActiveRecord::Migration
  def up
    add_column :pulitzer_post_type_content_element_types, :text_editor_id, :integer
    # Default index name is too long, so defined a name for it
    add_index :pulitzer_post_type_content_element_types, :text_editor_id, name: 'pulitzer_post_type_ce_text_editor_id'
    none = Pulitzer::TextEditor.first
    Pulitzer::PostTypeContentElementType.update_all(text_editor_id: none.id)
  end

  def down
    remove_column :pulitzer_post_type_content_element_types, :text_editor_id
  end
end
