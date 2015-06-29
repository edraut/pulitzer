# This migration comes from pulitzer (originally 20150619213436)
class CreatePulitzerTags < ActiveRecord::Migration
  def change
    create_table :pulitzer_tags do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
