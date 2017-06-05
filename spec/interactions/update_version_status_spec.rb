require 'rails_helper'

describe Pulitzer::UpdateVersionStatus do
  let(:post)        { Pulitzer::Post.first }
  let(:version)     { post.preview_version }

  describe "#call" do
    subject { described_class.new(version, :active) }

    context "with associated tags" do
      let(:tag1) { create :tag, name: "The North Remembers" }
      let(:tag2) { create :tag, name: "The South Forgets"   }

      before do
        create :post_tag, label: tag1, version: version
        create :post_tag, label: tag2, version: version
      end

      it "touches the associated tags" do
        version.tags.each do |tag|
          expect(tag).to receive(:touch).once
        end
        subject.call
      end

    end
  end

  it 'activates a version' do
    expect(version.status).to eq 'preview'
    Pulitzer::UpdateVersionStatus.new(version, :active).call
    post.reload
    expect(post.active_version.id).to eq version.id
    expect(post.preview_version).to be_instance_of Pulitzer::Version
    expect(post.preview_version.id).not_to eq version.id
    expect(post.preview_version.content_elements.count).to eq 11
  end

  it 'abandons a version' do
    expect(version.status).to eq 'preview'
    Pulitzer::UpdateVersionStatus.new(version, :active).call
    version.reload
    expect(version.status).to eq 'active'
    preview = post.preview_version
    Pulitzer::UpdateVersionStatus.new(preview, :abandoned).call
    preview.reload
    abandoned = preview
    expect(abandoned.status).to eq 'abandoned'
    expect(post.preview_version).to be_instance_of Pulitzer::Version
    expect(post.preview_version.id).not_to eq abandoned.id
    expect(post.preview_version.content_elements.count).to eq 11
  end

  it 'unpublish a version' do
    expect(version.status).to eq 'preview'
    Pulitzer::UpdateVersionStatus.new(version, :active).call
    version.reload
    expect(version.status).to eq 'active'
    Pulitzer::UpdateVersionStatus.new(version, :abandoned).call
    abandoned = version.reload
    expect(abandoned.status).to eq 'abandoned'
    expect(post.preview_version).to be_instance_of Pulitzer::Version
    expect(post.preview_version.id).not_to eq abandoned.id
    expect(post.preview_version.content_elements.count).to eq 11
  end
end
