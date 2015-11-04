# This migration comes from pulitzer (originally 20151029220558)
class ChangePostElementsToVersions < ActiveRecord::Migration
  def change
    rename_column :pulitzer_content_elements, :post_id, :version_id
    rename_column :pulitzer_post_tags, :post_id, :version_id
  end
end
