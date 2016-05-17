require 'rails_helper'

describe Pulitzer::CreatePostContentElements do
  let(:post_type) { create(:post_type, :with_content_elements) }
  let(:post)      { create(:post, post_type: post_type) }

  it 'Copies content elements to preview version' do
    expect(post_type.post_type_content_element_types.size).to eq 3
    expect(post.preview_version.content_elements.size).to eq 0
    Pulitzer::CreatePostContentElements.new(post).call
    expect(post.preview_version.content_elements.size).to eq 3
  end

  it 'Copies free form sections to preview version' do
    ff_post_type = create(:post_type, :with_free_form_sections)
    ff_post = ff_post_type.posts.create title: 'test'
    expect(ff_post_type.free_form_section_types.size).to eq 3
    expect(ff_post.preview_version.free_form_sections.size).to eq 0
    Pulitzer::CreatePostContentElements.new(ff_post).call
    expect(ff_post.preview_version.free_form_sections.size).to eq 3
  end
end
