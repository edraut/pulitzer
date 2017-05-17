class CreatePostTypeVersion < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_post_type_versions do |t|
      t.references :pulitzer_post_type, index: true
      t.integer :version_number, default: 1, null: false
      t.string :status, default: 'preview', null: false
    end
  end
end
