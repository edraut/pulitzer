class CreatePulitzerPartialTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_partial_types do |t|
      t.integer :free_form_section_type_id
      t.string :label
      t.integer :sort_order
      t.integer :layout_id
      t.integer :post_type_id
    end
  end
end
