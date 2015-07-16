# This migration comes from pulitzer (originally 20150618224344)
class CreatePulitzerPostTypes < ActiveRecord::Migration
  def change
    create_table :pulitzer_post_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
