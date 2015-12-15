require 'rails_helper'

describe Pulitzer::CloneVersion do
  let(:version)     { create(:version, :with_content_elements) }
  let(:new_version) { create(:version)}

  it 'Clones version content elements' do
    expect(version.content_elements.size).to eq 3
    expect(new_version.content_elements.size).to eq 0
    Pulitzer::CloneVersion.new(version, new_version).call
    expect(new_version.content_elements.size).to eq 3
  end
end
