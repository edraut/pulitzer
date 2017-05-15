require 'rails_helper'

describe Pulitzer::DestroyFreeFormSectionPartials do
  let!(:partial_type)           { create(:partial_type) }
  let(:post_type)               { free_form_section_type.post_type }
  let!(:post)                   { create(:post, post_type: post_type) }
  let(:preview_version)         { post.preview_version }
  let(:free_form_section_type)  { partial_type.free_form_section_type }

  it 'Creates partial to post type posts' do
    Pulitzer::CreatePostTypeFreeFormSections.new(free_form_section_type).call
    expect(preview_version.free_form_sections.first.partials).to eq []
    Pulitzer::CreateFreeFormSectionPartials.new(partial_type).call
    expect(preview_version.free_form_sections.first.partials.count).to eq 1
    Pulitzer::DestroyFreeFormSectionPartials.new(partial_type).call
    expect(preview_version.free_form_sections.first.partials.count).to eq 0
  end
end
