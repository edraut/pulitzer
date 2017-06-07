require 'rails_helper'

describe Pulitzer::UpdatePostTypeContentElements do
  let(:version)     { post.preview_version }
  let(:post_type_version) {post_type.published_type_version}
  let(:post)        { post_type_version.posts.first }
  let(:post_type)   { Pulitzer::PostType.named('Welcome') }
  let(:content_element_type) { Pulitzer::ContentElementType.find_by name: 'Text'}
  let(:ptcet)       { post_type_version.post_type_content_element_types.create(content_element_type_id: content_element_type.id, label: 'A New Field for this Post Type')}

  describe "#call" do

    it "updates a content element in a preview version" do
      ptcet
      Pulitzer::CreatePostContentElements.new(post).call
      preview = post.preview_version
      expect(preview.content_elements.map(&:post_type_content_element_type_id)).to include(ptcet.id)
      ptcet.update label: 'A changed label'
      Pulitzer::UpdatePostTypeContentElements.new(ptcet, 'A New Field for this Post Type').call
      content_element = preview.reload.content_elements.detect{|ce| ce.post_type_content_element_type_id == ptcet.id}
      expect(content_element.label).to eq('A changed label')
    end

    it "doesn't blow up if a post has no preview version" do
      version.update_columns status: 'archived'
      expect(post.reload.preview_version).to be_nil
      # There is no preview version for the post, but we don't blow up
      Pulitzer::UpdatePostTypeContentElements.new(ptcet).call
    end

  end
end
