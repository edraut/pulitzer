# This migration comes from pulitzer (originally 20150619213457)
class CreatePulitzerPostTags < ActiveRecord::Migration
  def change
    create_table :pulitzer_post_tags do |t|
      t.integer :post_id
      t.integer :label_id
      t.integer :label_type

      t.timestamps null: false
    end
  end
end
