class AddLabelToPartial < ActiveRecord::Migration
  def change
    add_column :pulitzer_partials, :label, :string
  end
end
