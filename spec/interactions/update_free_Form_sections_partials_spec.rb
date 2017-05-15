require 'rails_helper'

describe Pulitzer::UpdateFreeFormSectionPartials do
  let!(:partial_type)           { create(:partial_type) }
  let(:post_type)               { free_form_section_type.post_type }
  let!(:post)                   { create(:post, post_type: post_type) }
  let(:preview_version)         { post.preview_version }
  let(:free_form_section_type)  { partial_type.free_form_section_type }

  it 'Creates partial to post type posts' do
    Pulitzer::CreatePostTypeFreeFormSections.new(free_form_section_type).call
    Pulitzer::CreateFreeFormSectionPartials.new(partial_type).call
    partial = preview_version.free_form_sections.first.partials.first
    expect(partial.label).to eq partial_type.label
    old_label = partial_type.label
    partial_type.update_attributes(label: 'new label')
    Pulitzer::UpdateFreeFormSectionPartials.new(partial_type, old_label).call
    partial = preview_version.free_form_sections.first.partials.reload.first
    expect(partial.label).to eq 'new label'
  end
end
