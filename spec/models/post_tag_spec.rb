require 'rails_helper'

describe Pulitzer::PostTag do
  let(:post_tag) { build :post_tag }

  it 'has a valid factory' do
    expect(post_tag).to be_valid
  end

  describe "Active Model validations" do
    it { should validate_presence_of(:version) }
    it { should validate_presence_of(:label) }
  end

  describe "ActiveRecord associations" do
    it { should belong_to(:version) }
    it { should belong_to(:label) }
  end
end
