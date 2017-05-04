class CreatePulitzerContentElementTypes < ActiveRecord::Migration
  def change
    create_table :pulitzer_content_element_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
