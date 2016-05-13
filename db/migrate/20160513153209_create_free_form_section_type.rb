class CreateFreeFormSectionType < ActiveRecord::Migration
  def change
    create_table :free_form_section_types do |t|
      t.integer :post_type_id
      t.string :name
    end
  end
end
