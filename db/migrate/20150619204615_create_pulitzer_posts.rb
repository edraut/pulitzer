class CreatePulitzerPosts < ActiveRecord::Migration
  def change
    create_table :pulitzer_posts do |t|
      t.string :title
      t.integer :post_type_id
      t.string :status, default: 'unpublished'

      t.timestamps null: false
    end
  end
end
