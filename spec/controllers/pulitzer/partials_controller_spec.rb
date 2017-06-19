require 'rails_helper'

describe Pulitzer::PartialsController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.create(name: 'Centered Text White BG', plural: true, kind: Pulitzer::PostType.kinds[:partial]) }
  let(:post_type_version) {post_type.post_type_versions.create(status: :published)}
  let(:free_form_section) { Pulitzer::FreeFormSection.create(name: 'free as a bird') }
  let(:partial) { free_form_section.partials.create(post_type_version_id: post_type_version.id, label: 'test partial') }

  describe "#amenities", type: :request do
    it "renders the new form" do
      post_type_version
      get pulitzer.new_partial_path partial: {free_form_section_id: free_form_section.id}
      expect(response.status).to eq 200
      expect(response.body).to match post_type_version.name      
    end

    it "creates a new partial" do
      bg = post_type_version.background_styles.create(display_name: 'Grey', css_class_name: 'grey')
      just = post_type_version.justification_styles.create(display_name: 'Left', css_class_name: 'left')
      sf = post_type_version.sequence_flow_styles.create(display_name: 'Begin Sequence', css_class_name: 'begin-sequence')
      arr = post_type_version.arrangement_styles.create(display_name: 'Image Right', view_file_name: 'image-right')
      post pulitzer.partials_path partial: {
        post_type_version_id: post_type_version.id, free_form_section_id: free_form_section.id,
        justification_style_id: just.id, background_style_id: bg.id,
        sequence_flow_style_id: sf.id, arrangement_style_id: arr.id
      }
      expect(response.status).to eq 200
      partial = Pulitzer::Partial.order(id: :desc).first
      expect(partial.free_form_section_id).to eq free_form_section.id
      expect(partial.post_type_version_id).to eq post_type_version.id
      expect(response.body).to match('Grey')
      expect(response.body).to match('Left')
      expect(response.body).to match('Begin Sequence')
      expect(response.body).to match('image-right')
    end

    it "edits a partial" do
      get pulitzer.edit_partial_path id: partial.id
      expect(response.status).to eq 200
      
      expect(response.body).to match partial.label
    end

    it "updates a partial" do
      other_post_type = Pulitzer::PostType.create(name: 'Left Text White BG', plural: true, kind: Pulitzer::PostType.kinds[:partial])
      opt_version = other_post_type.post_type_versions.create
      patch pulitzer.partial_path id: partial.id, partial: {post_type_version_id: opt_version.id}
      expect(response.status).to eq 200
      expect(partial.reload.name).to eq 'Left Text White BG'
    end

  end # /search
end