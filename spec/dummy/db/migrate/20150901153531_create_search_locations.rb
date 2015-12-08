class CreateSearchLocations < ActiveRecord::Migration
  def change
    create_table :search_locations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
