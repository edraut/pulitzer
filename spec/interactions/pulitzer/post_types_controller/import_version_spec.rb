require 'rails_helper'

describe Pulitzer::PostTypesController::ImportVersion do
  let(:post_type) {Pulitzer::PostType.first}

  it "imports a version" do
    old_ptv = post_type.published_type_version
    ptv_json = Pulitzer::PostTypeVersionsController::Export.new(old_ptv).call
    json_file = StringIO.new(ptv_json)
    post_type_version = Pulitzer::PostTypesController::ImportVersion.new(post_type, {import_json: json_file}).call
    expect(post_type_version.version_number).to eq old_ptv.version_number + 1
    expect(post_type_version.status).to eq 'incomplete'
  end
end
