require 'rails_helper'

describe Pulitzer::CloneVersion do
  let(:version)     { create(:version, :with_content_elements) }

  it 'Clones version content elements' do
    expect(version.content_elements.size).to eq 3
    version.post.create_processing_version
    new_version = Pulitzer::CloneVersion.new(version).call
    expect(new_version.content_elements.size).to eq 3
  end

  it 'Clones version free form sections' do
    ff_version = create(:version, :with_free_form_sections)
    expect(ff_version.free_form_sections.size).to eq 3
    ff_version.post.create_processing_version
    new_version = Pulitzer::CloneVersion.new(ff_version).call
    expect(new_version.free_form_sections.size).to eq 3
  end

  it 'Clones a valid content element' do
    version.post.create_processing_version
    new_version = Pulitzer::CloneVersion.new(version).call
    content_element = new_version.content_elements.first
    expect(content_element.label).to match "Slide 1 content element"
    expect(content_element.body).to match "I pledge my life"
    expect(content_element.type.to_s).to match "text"
  end
end
