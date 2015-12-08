# This migration comes from pulitzer (originally 20151026180630)
class AddTextEditorToPulitzerPostTypeContentElementTypes < ActiveRecord::Migration
  def up
    add_column :pulitzer_post_type_content_element_types, :text_editor, :string
    Pulitzer::PostTypeContentElementType.update_all(text_editor: 'None')
  end

  def down
    remove_column :pulitzer_post_type_content_element_types, :text_editor
  end
end
