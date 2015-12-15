require 'rails_helper'

describe Pulitzer::CreatePostContentElements do
  it 'With active record' do
    post = Pulitzer::Post.create(title: 'Just a test 2')
    post_type =  create(:post_type, :with_content_elements)
    post.update(post_type: post_type)
    expect(post_type.post_type_content_element_types.size).to eq 3
    expect(post.content_elements).to be nil
    Pulitzer::CreatePostContentElements.new(post).call
    expect(post.reload.content_elements).to eq 3
  end

  it 'same spec with factory girl' do
    post = create :post
    post_type =  create(:post_type, :with_content_elements)
    post.update(post_type: post_type)
    expect(post_type.post_type_content_element_types.size).to eq 3
    expect(post.content_elements).to be nil
    Pulitzer::CreatePostContentElements.new(post).call
    expect(post.reload.content_elements).to eq 3
  end
end
