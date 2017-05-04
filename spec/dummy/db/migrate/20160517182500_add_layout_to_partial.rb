class AddLayoutToPartial < ActiveRecord::Migration
  def change
    add_column :pulitzer_partials, :layout_id, :integer
  end
end
