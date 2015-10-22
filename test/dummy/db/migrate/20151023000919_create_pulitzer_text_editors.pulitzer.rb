# This migration comes from pulitzer (originally 20151021212937)
class CreatePulitzerTextEditors < ActiveRecord::Migration
  def change
    create_table :pulitzer_text_editors do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
