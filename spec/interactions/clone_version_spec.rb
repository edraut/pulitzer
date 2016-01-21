require 'rails_helper'

describe Pulitzer::CloneVersion do
  let(:version)     { create(:version, :with_content_elements) }

  it 'Clones version content elements' do
    expect(version.content_elements.size).to eq 3
    new_version = Pulitzer::CloneVersion.new(version).call
    expect(new_version.content_elements.size).to eq 3
  end

  it 'Clones a valid content element' do
    new_version = Pulitzer::CloneVersion.new(version).call
    content_element = new_version.content_elements.first
    expect(content_element.title).to eq "Night's Watch"
    expect(content_element.label).to match "Slide 1 content element"
    expect(content_element.body).to match "I pledge my life"
    expect(content_element.type.to_s).to match "text"
  end
end
