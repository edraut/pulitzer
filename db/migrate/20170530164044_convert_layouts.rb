class ConvertLayouts < ActiveRecord::Migration[5.0]
  def change
    drop_table :pulitzer_layouts
    create_table :pulitzer_styles do |t|
      t.integer :post_type_content_element_type_id
      t.string :display_name
      t.string :css_class_name
    end

    Pulitzer::ContentElement.reset_column_information
    Pulitzer::ContentElementType.find_or_create_by(name: 'Clickable')
  end
end
