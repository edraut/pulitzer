require 'rails_helper'

describe Pulitzer::CreateFreeFormSectionPartials do
  let!(:partial_type)           { create(:partial_type) }
  let(:post_type_version)               { free_form_section_type.post_type_version }
  let!(:post)                   { create(:post, post_type_version: post_type_version) }
  let(:preview_version)         { post.preview_version }
  let(:free_form_section_type)  { partial_type.free_form_section_type }

  it 'Creates partial to post type posts' do
    Pulitzer::CreatePostTypeFreeFormSections.new(free_form_section_type).call
    expect(preview_version.free_form_sections.first.partials).to eq []
    create_partials = Pulitzer::CreateFreeFormSectionPartials.new(partial_type).call
    preview_version.reload
    partial = preview_version.free_form_sections.first.partials.first
    expect(partial.label).to eq partial_type.label
    expect(partial.post_type_version_id).to eq partial_type.post_type_version_id
    expect(partial.layout_id).to eq partial_type.layout_id
    expect(partial.sort_order).to eq partial_type.sort_order
  end
end
