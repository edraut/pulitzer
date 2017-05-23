require 'rails_helper'

describe Pulitzer::ArrangementStylesController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.create(name: 'partial with various layout styles', kind: Pulitzer::PostType.kinds[:partial], plural: false) }
  let(:arrangement_style) { post_type.arrangement_styles.create(display_name: 'White', view_file_name: 'white') }

  describe "arrangement_styles", type: :request do
    it "renders the new form" do
      get pulitzer.new_arrangement_style_path(arrangement_style: {post_type_id: post_type.id})
      expect(response.status).to eq 200
      expect(response.body).to match /arrangement_style\[display_name\]/
    end

    it "creates a new arrangement_style" do
      post pulitzer.arrangement_styles_path(
        arrangement_style: {
          post_type_id: post_type.id,
          view_file_name: 'pretty-arrangement',
          display_name: 'Pretty Arrangement'})
      expect(response.status).to eq 200
      bs = Pulitzer::ArrangementStyle.order(id: :desc).first
      expect(bs.view_file_name).to eq 'pretty-arrangement'
      expect(bs.display_name).to eq 'Pretty Arrangement'
    end

    it "edits an arrangement_style" do
      get pulitzer.edit_arrangement_style_path id: arrangement_style.id
      expect(response.status).to eq 200
      
      expect(response.body).to match 'White'
    end

    it "updates an arrangement_style" do
      patch pulitzer.arrangement_style_path id: arrangement_style.id, arrangement_style: {display_name: 'edited name'}
      expect(response.status).to eq 200
      expect(arrangement_style.reload.display_name).to eq 'edited name'
    end

    it "deletes an arrangement_style" do
      delete pulitzer.arrangement_style_path id: arrangement_style.id
      expect(response.status).to eq 200
      expect(Pulitzer::ArrangementStyle.find_by(id: arrangement_style.id)).to be nil
    end

  end # /search
end