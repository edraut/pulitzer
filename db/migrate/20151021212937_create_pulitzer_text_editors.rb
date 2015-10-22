class CreatePulitzerTextEditors < ActiveRecord::Migration
  def change
    create_table :pulitzer_text_editors do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
