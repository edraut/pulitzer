class ReconnectPostTypeToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :pulitzer_posts, :post_type_version_id, :integer
    Pulitzer::Post.reset_column_information
    Pulitzer::PostType.all.each do |pt|
      ptv = pt.published_type_version
      ptv ||= pt.post_type_versions.create(status: 'active')
      Pulitzer::Post.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
    end
    remove_column :pulitzer_posts, :post_type_id
    add_index :pulitzer_posts, :post_type_version_id
  end
end
