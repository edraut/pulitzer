require 'rails_helper'

describe Pulitzer::CloneVersion do
  let(:post_type)   { Pulitzer::PostType.named('Welcome')}
  let(:post)        { post_type.posts.first }
  let(:version)     { post.preview_version }

  it 'Clones version content elements' do
    expect(version.content_elements.size).to eq 10
    version.post.create_processing_version
    new_version = Pulitzer::CloneVersion.new(version).call
    expect(new_version.content_elements.size).to eq 10
  end

  it 'Clones version free form sections' do
    expect(version.free_form_sections.size).to eq 2
    version.post.create_processing_version
    new_version = Pulitzer::CloneVersion.new(version).call
    expect(new_version.free_form_sections.size).to eq 2
  end

  it 'Clones a valid content element' do
    version.post.create_processing_version
    new_version = Pulitzer::CloneVersion.new(version).call
    content_element = new_version.content_elements.first
    expect(content_element.label).to match "Hero Title 1"
    expect(content_element.type.to_s).to match "text"
  end
end
