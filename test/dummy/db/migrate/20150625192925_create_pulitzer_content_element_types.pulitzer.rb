# This migration comes from pulitzer (originally 20150618225402)
class CreatePulitzerContentElementTypes < ActiveRecord::Migration
  def change
    create_table :pulitzer_content_element_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
