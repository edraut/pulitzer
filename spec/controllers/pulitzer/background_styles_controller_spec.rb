require 'rails_helper'

describe Pulitzer::BackgroundStylesController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.create(name: 'partial with various layout styles', kind: Pulitzer::PostType.kinds[:partial], plural: false) }
  let(:background_style) { post_type.background_styles.create(display_name: 'White', css_class_name: 'white') }

  describe "background_styles", type: :request do
    it "renders the new form" do
      get pulitzer.new_background_style_path(background_style: {post_type_id: post_type.id})
      expect(response.status).to eq 200
      expect(response.body).to match /background_style\[display_name\]/
    end

    it "creates a new background_style" do
      post pulitzer.background_styles_path(
        background_style: {
          post_type_id: post_type.id,
          css_class_name: 'pretty-class',
          display_name: 'Pretty Class'})
      expect(response.status).to eq 200
      bs = Pulitzer::BackgroundStyle.order(id: :desc).first
      expect(bs.css_class_name).to eq 'pretty-class'
      expect(bs.display_name).to eq 'Pretty Class'
    end

    it "edits an background_style" do
      get pulitzer.edit_background_style_path id: background_style.id
      expect(response.status).to eq 200
      
      expect(response.body).to match 'White'
    end

    it "updates an background_style" do
      patch pulitzer.background_style_path id: background_style.id, background_style: {display_name: 'edited name'}
      expect(response.status).to eq 200
      expect(background_style.reload.display_name).to eq 'edited name'
    end

    it "deletes an background_style" do
      delete pulitzer.background_style_path id: background_style.id
      expect(response.status).to eq 200
      expect(Pulitzer::BackgroundStyle.find_by(id: background_style.id)).to be nil
    end

  end # /search
end