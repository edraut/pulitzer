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

  describe "#posts" do
    subject { create :tag }
    let(:version) { create :version, status: :active }
    let(:post)    { version.post }

    before do
      create :post_tag, version: version, label: subject
    end

    it "returns the posts tagged with the given tag" do
      expect(subject.posts).to include(post)
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

  describe "#root?" do
    let!(:tag1) { create :tag, hierarchical: true  }
    let!(:tag2) { create :tag, hierarchical: false }
    let!(:tag3) { create :tag, hierarchical: true, parent: tag1 }

    it "returns true for root hierarchical tags" do
      expect(tag1.root?).to eq true
    end

    it "returns false for flat tags" do
      expect(tag2.root?).to eq false
    end

    it "returns false for children tags" do
      expect(tag3.root?).to eq false
    end
  end

end
