# This migration comes from pulitzer (originally 20151029220558)
class ChangePostElementsToVersions < ActiveRecord::Migration
  def up
    rename_column :pulitzer_content_elements, :post_id, :version_id
    rename_column :pulitzer_post_tags, :post_id, :version_id
    Pulitzer::ContentElements.reset_column_information
    Pulitzer::PostTags.reset_column_information

    # Clone post content elements and clone tags, and assign them to the new version
    Pulitzer::Post.find_each do |post|
      version = post.create_preview_version
      content_elements = Pulitzer::ContentElements.where(version_id: post.id)
      post.content_elements.each do |ce|
        element = ce.dup
        element.version_id = nil
        version.content_elements << element
      end
      content_elements = Pulitzer::PostTags.where(version_id: post.id)
      post.post_tags.each do |pt|
        post_tag = pt.dup
        post_tag.version_id = nil
        version.post_tags << post_tag
      end
    end
  end

  def down
    rename_column :pulitzer_content_elements, :version_id, :post_id
    rename_column :pulitzer_post_tags, :version_id, :post_id
  end
end
