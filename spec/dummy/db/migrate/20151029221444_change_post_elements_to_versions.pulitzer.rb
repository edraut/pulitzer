# This migration comes from pulitzer (originally 20151029220558)
class ChangePostElementsToVersions < ActiveRecord::Migration
  def up
    rename_column :pulitzer_content_elements, :post_id, :version_id
    rename_column :pulitzer_post_tags, :post_id, :version_id
    Pulitzer::ContentElement.reset_column_information
    Pulitzer::PostTag.reset_column_information

    # Clone post content elements and clone tags, and assign them to the new version
    Pulitzer::Post.find_each do |post|
      version = post.create_preview_version
      Pulitzer::ContentElement.where(version_id: post.id).update_all(version_id: version.id)
      Pulitzer::PostTag.where(version_id: post.id).update_all(version_id: version.id)
    end
  end

  def down
    rename_column :pulitzer_content_elements, :version_id, :post_id
    rename_column :pulitzer_post_tags, :version_id, :post_id
  end
end
