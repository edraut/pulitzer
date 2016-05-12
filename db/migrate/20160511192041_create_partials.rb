class CreatePartials < ActiveRecord::Migration
  def change
    create_table :pulitizer_partials do |t|
      t.integer :post_type_id
      t.integer :version_id
      t.integer :sort_order
    end
  end
end
