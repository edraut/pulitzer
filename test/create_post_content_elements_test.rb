require 'test_helper'

describe Pulitzer::CreatePostContentElements do
  it 'With active record' do
    post_type =  Pulitzer::PostType.find_by(name: 'Winterfell News')
    post = post_type.posts.create(title: 'Just a test 2')
    post.update(post_type: post_type)
    post_type.post_type_content_element_types.size.must_equal 3
    post.content_elements.must_be :nil?
    Pulitzer::CreatePostContentElements.new(post).call
    post.reload.preview_version.content_elements.length.must_equal 3
  end
end
