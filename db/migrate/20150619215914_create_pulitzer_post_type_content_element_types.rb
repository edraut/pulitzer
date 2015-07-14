class CreatePulitzerPostTypeContentElementTypes < ActiveRecord::Migration
  def change
    create_table :pulitzer_post_type_content_element_types do |t|
      t.integer :post_type_id
      t.integer :content_element_type_id
      t.string :label
      t.integer :height, default: 100
      t.integer :width, default: 100

      t.timestamps null: false
    end
  end
end
