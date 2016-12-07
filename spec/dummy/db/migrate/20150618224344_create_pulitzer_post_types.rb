class CreatePulitzerPostTypes < ActiveRecord::Migration
  def change
    create_table :pulitzer_post_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
