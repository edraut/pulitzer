require 'rails_helper'

describe Pulitzer::Post do
  let(:post) { build :post }

  it 'has a valid factory' do
    expect(post).to be_valid
  end

  describe "Active Model validations" do
    it { should validate_presence_of(:title) }
  end

  describe "ActiveRecord associations" do
    it { should belong_to(:post_type_version) }
  end

  describe "#active_version" do
    let(:post) { create :post }
    let!(:preview) { create :version, post: post, status: :preview }
    let!(:active)  { create :version, post: post, status: :active  }

    it "should return the version with status = active" do
      expect(post.active_version).to eq active
    end
  end

  describe "#get_active_version!" do
    let(:post) { create :post} 
    let!(:preview) { create :version, post: post, status: :preview }

    it "should raise an error if the active version is not found" do
      expect{post.get_active_version!}.to raise_error Pulitzer::VersionMissingError
    end
  end

  describe "#get_preview_version!" do
    let(:post) { create :post} 

    it "should raise an error if the version is processing" do
      processing = post.preview_version
      processing.update_columns status: 'processing'
      expect{post.get_preview_version!}.to raise_error Pulitzer::VersionProcessingError
    end

    it "should raise an error if the version is processing" do
      post.preview_version.destroy
      expect{post.get_preview_version!}.to raise_error Pulitzer::VersionMissingError
    end
  end

  describe "Generate a slug" do
    let(:post) { create :post }

    it 'for a new post' do
      expect(post.slug).to match 'winterfell-news-'
    end

    it 'updating a post' do
      post.update title: 'The new King in the North'
      expect(post.slug).to eq 'the-new-king-in-the-north'
    end
  end
end
