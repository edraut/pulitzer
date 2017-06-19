require 'rails_helper'

describe Pulitzer::FreeFormSectionTypesController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.create(name: 'free as a bird', plural: true, kind: Pulitzer::PostType.kinds[:template]) }
  let(:post_type_version) {post_type.post_type_versions.create}
  let(:free_form_section_type) { post_type_version.free_form_section_types.create(name: 'main content') }

  describe "#amenities", type: :request do
    it "renders the new form" do
      post_type_version
      get pulitzer.new_free_form_section_type_path post_type_version_id: post_type_version.id
      expect(response.status).to eq 200
      expect(response.body).to match /free_form_section_type\[name\]/
    end

    it "creates a new free form section type" do
      post pulitzer.free_form_section_types_path free_form_section_type: {post_type_version_id: post_type_version.id, name: 'test sidebar'}
      expect(response.status).to eq 200
      ffst = Pulitzer::FreeFormSectionType.order(id: :desc).first
      expect(ffst.name).to eq "test sidebar"
    end

    it "edits an free_form_section_type" do
      get pulitzer.edit_free_form_section_type_path id: free_form_section_type.id
      expect(response.status).to eq 200
      
      expect(response.body).to match 'main content'
    end

    it "updates an free_form_section_type" do
      patch pulitzer.free_form_section_type_path id: free_form_section_type.id, free_form_section_type: {name: 'edited name'}
      expect(response.status).to eq 200
      expect(free_form_section_type.reload.name).to eq 'edited name'
    end

    it "deletes an free_form_section_type" do
      delete pulitzer.free_form_section_type_path id: free_form_section_type.id
      expect(response.status).to eq 200
      expect(Pulitzer::FreeFormSectionType.find_by(id: free_form_section_type.id)).to be nil
    end

  end # /search
end