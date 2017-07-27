require 'rails_helper'

describe Pulitzer::PostTypeVersionsController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:ptv){Pulitzer::PostTypeVersion.first}

  describe "#create", type: :request do
    it "exports a post type version" do
      get pulitzer.export_post_type_version_path id: ptv.id
      expect(response.status).to eq 200
      response_json = JSON.parse(response.body)
      expect(response_json['version_number']).to eq ptv.version_number
      expect(response_json['status']).to eq ptv.status
      expect(response_json["post_type_content_element_types_attributes"].length).to eq ptv.post_type_content_element_types.length
    end

  end
end
