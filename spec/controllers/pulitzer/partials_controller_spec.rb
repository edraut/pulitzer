require 'rails_helper'

describe Pulitzer::PartialsController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.create(name: 'Centered Text White BG', plural: true, kind: Pulitzer::PostType.kinds[:partial]) }
  let(:free_form_section) { Pulitzer::FreeFormSection.create(name: 'free as a bird') }
  let(:partial) { free_form_section.partials.create(post_type_id: post_type.id) }

  describe "#amenities" do
    it "renders the new form" do
      post_type
      get :new, partial: {free_form_section_id: free_form_section.id}
      expect(response.status).to eq 200
      expect(response.body).to match post_type.name      
    end

    it "creates a new partial" do
      post :create, partial: {post_type_id: post_type.id, free_form_section_id: free_form_section.id}
      expect(response.status).to eq 200
      partial = Pulitzer::Partial.order(id: :desc).first
      expect(partial.free_form_section_id).to eq free_form_section.id
      expect(partial.post_type_id).to eq post_type.id
    end

    it "edits a partial" do
      get :edit, id: partial.id
      expect(response.status).to eq 200
      
      expect(response.body).to match post_type.name
    end

    it "updates a partial" do
      other_post_type = Pulitzer::PostType.create(name: 'Left Text White BG', plural: true, kind: Pulitzer::PostType.kinds[:partial])
      patch :update, id: partial.id, partial: {post_type_id: other_post_type.id}
      expect(response.status).to eq 200
      expect(partial.reload.name).to eq 'Left Text White BG'
    end

  end # /search
end