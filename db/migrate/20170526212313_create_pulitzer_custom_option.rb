class CreatePulitzerCustomOption < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_custom_options do |t|
      t.integer :custom_option_list_id
      t.string :display
      t.string :value
    end
  end
end
