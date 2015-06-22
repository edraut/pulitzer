class CreatePulitzerContentElements < ActiveRecord::Migration
  def change
    create_table :pulitzer_content_elements do |t|
      t.string :label
      t.string :title
      t.text :body
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
