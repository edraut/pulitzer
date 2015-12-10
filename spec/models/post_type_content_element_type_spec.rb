require 'rails_helper'

describe Pulitzer::PostTypeContentElementType do
  let(:post_type_content_element_type) { build :post_type_content_element_type }

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
end
