class CreatePulitzerSequenceFlowClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_sequence_flow_styles do |t|
      t.integer :post_type_id
      t.string :display_name
      t.string :css_class_name
    end
  end
end
