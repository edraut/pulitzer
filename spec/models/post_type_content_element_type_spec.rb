require 'rails_helper'

describe Pulitzer::PostTypeContentElementType do
  let(:post_type) {Pulitzer::PostType.named('Welcome')}
  let(:post_type_content_element_type) { post_type.post_type_content_element_types.first }
  let(:cet) {post_type_content_element_type.content_element_type}

  it 'has a valid factory' do
    expect(post_type_content_element_type).to be_valid
  end

  describe "Active Model validations" do
    it { should validate_presence_of(:label) }
  end

  describe "ActiveRecord associations" do
    it { should belong_to(:post_type) }
    it { should belong_to(:content_element_type) }
    it { should have_one(:content_element) }
  end

  describe "sort order" do
    it "creates elements with the next sort order" do
      last_element_index = post_type_content_element_type.highest_sibling_sort
      ptcet = post_type.post_type_content_element_types.create(content_element_type: cet, label: 'Test Element')
      expect(ptcet.sort_order).to eq (last_element_index + 1)
    end
  end
end
