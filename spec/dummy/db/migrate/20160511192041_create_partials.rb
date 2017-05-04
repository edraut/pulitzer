class CreatePartials < ActiveRecord::Migration
  def change
    create_table :pulitzer_partials do |t|
      t.integer :post_type_id
      t.integer :free_form_section_id
      t.integer :sort_order
    end
  end
end
