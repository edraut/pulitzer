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
end
