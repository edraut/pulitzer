require 'rails_helper'

describe Pulitzer::UpdateVersionStatus do
  let(:version)     { create(:version, :with_content_elements) }
  let(:post)        { version.post }
  it 'activates a version' do
    expect(version.status).to eq 'preview'
    Pulitzer::UpdateVersionStatus.new(version, :active).call
    expect(post.active_version.id).to eq version.id
    expect(post.preview_version).to be_instance_of Pulitzer::Version
    expect(post.preview_version.id).not_to eq version.id
    expect(post.preview_version.content_elements.count).to eq 3
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
    expect(post.preview_version.content_elements.count).to eq 3
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
    expect(post.preview_version.content_elements.count).to eq 3
  end
end
