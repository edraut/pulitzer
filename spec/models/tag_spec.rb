require 'rails_helper'

describe Pulitzer::Tag do
  let(:tag) { build :tag }

  it 'has a valid factory' do
    expect(tag).to be_valid
  end

  describe "Active Model validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "ActiveRecord associations" do
    it { should have_many(:post_tags).dependent(:destroy) }
    it { should have_many(:versions).through(:post_tags) }
  end
end
