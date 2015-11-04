class CreatePulitzerVersions < ActiveRecord::Migration
  def change
    create_table :pulitzer_versions do |t|
      t.integer :status, deafult: 0
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
