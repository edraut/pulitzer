class AddKindToPulitzerContentElements < ActiveRecord::Migration
  def change
    add_column :pulitzer_content_elements, :kind, :integer, default: 0
  end
end
