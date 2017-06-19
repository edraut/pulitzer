class CreatePostTypeVersion < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_post_type_versions do |t|
      t.integer :post_type_id, index: true
      t.integer :version_number, default: 1, null: false
      t.string :status, default: 'incomplete', null: false
    end
  end
end
