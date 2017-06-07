require 'rails_helper'

describe Pulitzer::CreatePartialContentElements do
  let(:post_type_version) { pt = create(:post_type_version, :with_content_elements)
                    pt.post_type.update_columns(kind: Pulitzer::PostType.kinds[:partial])
                    pt }
  let(:free_form_section) { Pulitzer::FreeFormSection.create name: 'test'}
  let(:partial)      { free_form_section.partials.create(post_type_version_id: post_type_version.id) }

  it 'Copies content elements to preview version' do
    expect(post_type_version.post_type_content_element_types.size).to eq 3
    expect(partial.content_elements.size).to eq 0
    Pulitzer::CreatePartialContentElements.new(partial).call
    expect(partial.content_elements.size).to eq 3
  end
end
