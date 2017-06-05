require 'rails_helper'

describe Pulitzer::JustificationStylesController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.create(name: 'partial with various layout styles', kind: Pulitzer::PostType.kinds[:partial], plural: false) }
  let(:justification_style) { post_type.justification_styles.create(display_name: 'White', css_class_name: 'white') }

  describe "justification_styles", type: :request do
    it "renders the new form" do
      get pulitzer.new_justification_style_path(justification_style: {post_type_id: post_type.id})
      expect(response.status).to eq 200
      expect(response.body).to match /justification_style\[display_name\]/
    end

    it "creates a new justification_style" do
      post pulitzer.justification_styles_path(
        justification_style: {
          post_type_id: post_type.id,
          css_class_name: 'pretty-class',
          display_name: 'Pretty Class'})
      expect(response.status).to eq 200
      bs = Pulitzer::JustificationStyle.order(id: :desc).first
      expect(bs.css_class_name).to eq 'pretty-class'
      expect(bs.display_name).to eq 'Pretty Class'
    end

    it "edits an justification_style" do
      get pulitzer.edit_justification_style_path id: justification_style.id
      expect(response.status).to eq 200
      
      expect(response.body).to match 'White'
    end

    it "updates an justification_style" do
      patch pulitzer.justification_style_path id: justification_style.id, justification_style: {display_name: 'edited name'}
      expect(response.status).to eq 200
      expect(justification_style.reload.display_name).to eq 'edited name'
    end

    it "deletes an justification_style" do
      delete pulitzer.justification_style_path id: justification_style.id
      expect(response.status).to eq 200
      expect(Pulitzer::JustificationStyle.find_by(id: justification_style.id)).to be nil
    end

  end # /search
end