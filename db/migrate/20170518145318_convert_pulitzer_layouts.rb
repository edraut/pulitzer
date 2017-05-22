class ConvertPulitzerLayouts < ActiveRecord::Migration[5.0]
  def change
    add_column :pulitzer_partials, :background_style_id, :integer
    add_column :pulitzer_partials, :justification_style_id, :integer
    add_column :pulitzer_partials, :sequence_flow_style_id, :integer
    add_column :pulitzer_partials, :arrangement_style_id, :integer
  end

end
