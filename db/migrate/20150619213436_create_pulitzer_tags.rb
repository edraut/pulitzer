class CreatePulitzerTags < ActiveRecord::Migration
  def change
    create_table :pulitzer_tags do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
