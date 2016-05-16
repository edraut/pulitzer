require 'spec_helper'

describe Pulitzer::FreeFormSectionTypesController do
  # render_views
  let(:post_type) { Pulitzer::PostType.create(name: 'free as a bird') }
  let(:free_form_section_type) { post_type.free_form_section_types.create(name: 'main content') }

  describe "#amenities" do
    it "creates a new free form section type" do
      post :create, free_form_section_type: {post_type_id: post_type.id, name: 'test sidebar'}
      expect(response.status).to eq 200
      ffst = FreeFormSectionType.order(id: :desc).first
      expect(ffst.name).to eq "test sidebar"
    end

    it "edits an free_form_section_type" do
      get :edit, id: free_form_section_type.id
      expect(response.status).to eq 200
      
      expect(response.body).to match 'main content'
    end

    it "updates an free_form_section_type" do
      patch :update, id: free_form_section_type.id, free_form_section_type: {name: 'edited name'}
      expect(response.status).to eq 200
      expect(free_form_section_type.reload.name).to eq 'edited name'
    end

    it "deletes an free_form_section_type" do
      delete :destroy, id: free_form_section_type.id
      expect(response.status).to eq 200
      expect(FreeFormSectionType.find_by(id: free_form_section_type.id)).to be nil
    end

  end # /search
end