# This migration comes from pulitzer (originally 20151029194354)
class CreatePulitzerVersions < ActiveRecord::Migration
  def change
    create_table :pulitzer_versions do |t|
      t.integer :status, default: 0
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
