class CreatePulitzerArrangementClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_arrangement_styles do |t|
      t.integer :post_type_id
      t.string :display_name
      t.string :view_file_name
    end
  end
end
