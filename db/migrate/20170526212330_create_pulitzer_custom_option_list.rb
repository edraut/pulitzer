class CreatePulitzerCustomOptionList < ActiveRecord::Migration[5.0]
  def change
    create_table :pulitzer_custom_option_lists do |t|
      t.string :name
    end
  end
end
