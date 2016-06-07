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
    it { should belong_to(:post_type) }
  end

  describe "#active_version" do
    let(:post) { create :post }
    let!(:preview) { create :version, post: post, status: :preview }
    let!(:active)  { create :version, post: post, status: :active  }

    it "should return the version with status = active" do
      expect(post.active_version).to eq active
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
