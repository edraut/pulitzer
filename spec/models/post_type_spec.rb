require 'rails_helper'

describe Pulitzer::PostType do
  let(:post_type) { build :post_type }

  it 'has a valid factory' do
    expect(post_type).to be_valid
  end

  describe "Active Model validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:kind) }
  end

  describe "ActiveRecord associations" do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:post_type_content_element_types).dependent(:destroy) }
    it { should have_many(:content_element_types).through(:post_type_content_element_types) }
  end

  describe 'ActiveRecord enums' do
    it { should define_enum_for(:kind).
      with([:template, :free_form, :hybrid]) }
  end
end
