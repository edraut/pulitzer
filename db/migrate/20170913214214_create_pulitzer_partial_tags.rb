class CreatePulitzerPartialTags < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_partial_tags do |t|
      t.integer :partial_id
      t.integer :label_id
      t.string :label_type

      t.timestamps
    end
  end
end
