class AddStatusToPulitzerPostTypeVersion < ActiveRecord::Migration[5.0]
  def change
    add_column :pulitzer_post_type_versions, :processing_status, :integer, default: 0
    add_column :pulitzer_post_type_versions, :processing_error_message, :text
  end
end
