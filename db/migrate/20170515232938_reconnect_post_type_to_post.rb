class ReconnectPostTypeToPost < ActiveRecord::Migration[5.0]
  def change
    Monocle.drop('travel_articles')
    Monocle.drop('travel_guides')
    add_column :pulitzer_posts, :post_type_version_id, :integer
    add_column :pulitzer_background_styles, :post_type_version_id, :integer
    add_column :pulitzer_justification_styles, :post_type_version_id, :integer
    add_column :pulitzer_sequence_flow_styles, :post_type_version_id, :integer
    add_column :pulitzer_arrangement_styles, :post_type_version_id, :integer
    add_column :pulitzer_post_type_content_element_types, :post_type_version_id, :integer
    add_column :pulitzer_partials, :post_type_version_id, :integer
    add_column :pulitzer_partial_types, :post_type_version_id, :integer
    add_column :pulitzer_free_form_section_types, :post_type_version_id, :integer

    Pulitzer::Post.reset_column_information
    Pulitzer::BackgroundStyle.reset_column_information
    Pulitzer::JustificationStyle.reset_column_information
    Pulitzer::SequenceFlowStyle.reset_column_information
    Pulitzer::ArrangementStyle.reset_column_information
    Pulitzer::Partial.reset_column_information
    Pulitzer::PartialType.reset_column_information
    Pulitzer::FreeFormSectionType.reset_column_information
    Pulitzer::PostTypeContentElementType.reset_column_information

    Pulitzer::PostType.all.each do |pt|
      ptv = pt.published_type_version
      ptv ||= pt.post_type_versions.create(status: 'published')
      Pulitzer::Post.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
      Pulitzer::BackgroundStyle.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
      Pulitzer::JustificationStyle.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
      Pulitzer::SequenceFlowStyle.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
      Pulitzer::ArrangementStyle.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
      Pulitzer::Partial.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
      Pulitzer::PartialType.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
      Pulitzer::FreeFormSectionType.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
      Pulitzer::PostTypeContentElementType.where(post_type_id: pt.id).update_all post_type_version_id: ptv.id
    end

    remove_column :pulitzer_post_type_content_element_types, :post_type_id
    remove_column :pulitzer_free_form_section_types, :post_type_id
    remove_column :pulitzer_partials, :post_type_id
    remove_column :pulitzer_sequence_flow_styles, :post_type_id
    remove_column :pulitzer_background_styles, :post_type_id
    remove_column :pulitzer_justification_styles, :post_type_id
    remove_column :pulitzer_arrangement_styles, :post_type_id
    remove_column :pulitzer_posts, :post_type_id

    add_index :pulitzer_posts, :post_type_version_id
    Monocle.create('travel_guides')
    Monocle.create('travel_articles')
  end
end
