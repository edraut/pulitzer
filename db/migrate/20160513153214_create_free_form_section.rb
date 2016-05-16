class CreateFreeFormSection < ActiveRecord::Migration
  def change
    create_table :pulitzer_free_form_sections do |t|
      t.integer :version_id
      t.integer :free_form_section_type_id
      t.string :name
    end
  end
end
