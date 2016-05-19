class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :pulitzer_layouts do |t|
      t.integer :post_type_id
      t.string :name
    end
  end
end
