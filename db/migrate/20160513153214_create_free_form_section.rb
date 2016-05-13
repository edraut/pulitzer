class CreateFreeFormSection < ActiveRecord::Migration
  def change
    create_table :free_form_sections do |t|
      t.integer :version_id
      t.string :name
    end
  end
end
