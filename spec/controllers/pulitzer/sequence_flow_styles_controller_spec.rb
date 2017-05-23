require 'rails_helper'

describe Pulitzer::SequenceFlowStylesController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.create(name: 'partial with various layout styles', kind: Pulitzer::PostType.kinds[:partial], plural: false) }
  let(:sequence_flow_style) { post_type.sequence_flow_styles.create(display_name: 'White', css_class_name: 'white') }

  describe "sequence_flow_styles", type: :request do
    it "renders the new form" do
      get pulitzer.new_sequence_flow_style_path(sequence_flow_style: {post_type_id: post_type.id})
      expect(response.status).to eq 200
      expect(response.body).to match /sequence_flow_style\[display_name\]/
    end

    it "creates a new sequence_flow_style" do
      post pulitzer.sequence_flow_styles_path(
        sequence_flow_style: {
          post_type_id: post_type.id,
          css_class_name: 'pretty-class',
          display_name: 'Pretty Class'})
      expect(response.status).to eq 200
      bs = Pulitzer::SequenceFlowStyle.order(id: :desc).first
      expect(bs.css_class_name).to eq 'pretty-class'
      expect(bs.display_name).to eq 'Pretty Class'
    end

    it "edits an sequence_flow_style" do
      get pulitzer.edit_sequence_flow_style_path id: sequence_flow_style.id
      expect(response.status).to eq 200
      
      expect(response.body).to match 'White'
    end

    it "updates an sequence_flow_style" do
      patch pulitzer.sequence_flow_style_path id: sequence_flow_style.id, sequence_flow_style: {display_name: 'edited name'}
      expect(response.status).to eq 200
      expect(sequence_flow_style.reload.display_name).to eq 'edited name'
    end

    it "deletes an sequence_flow_style" do
      delete pulitzer.sequence_flow_style_path id: sequence_flow_style.id
      expect(response.status).to eq 200
      expect(Pulitzer::SequenceFlowStyle.find_by(id: sequence_flow_style.id)).to be nil
    end

  end # /search
end