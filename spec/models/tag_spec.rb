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

  describe ".hierarchical" do
    subject { described_class }
    let!(:t1) { create :tag, hierarchical: true }
    let!(:t2) { create :tag, hierarchical: false }

    it "returns the tags that are hierarchical: true" do
      expect(subject.hierarchical).to include(t1)
      expect(subject.hierarchical).not_to include(t2)
    end
  end

  describe ".flat" do
    subject { described_class }
    let!(:t1) { create :tag, hierarchical: true }
    let!(:t2) { create :tag, hierarchical: false }

    it "returns the tags that are hierarchical: false" do
      expect(subject.flat).not_to include(t1)
      expect(subject.flat).to include(t2)
    end
  end

  describe "#children" do
    let(:tag) { create :tag }
    let!(:c1) { create :tag, parent: tag }
    let!(:c2) { create :tag, parent: tag }

    it "returns the children of the parent tag" do
      expect(tag.children).to include(c1)
      expect(tag.children).to include(c2)
    end
  end

end
