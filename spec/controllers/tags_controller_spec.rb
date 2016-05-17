require 'rails_helper'

describe Pulitzer::TagsController do

  routes { Pulitzer::Engine.routes }

  describe "#index" do
    let!(:flat_tag) { create :tag, hierarchical: false }
    let!(:root_tag) { create :tag, hierarchical: true  }

    before { get :index }

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "assigns to flat tags" do
      expect(assigns[:flat_tags]).to eq [flat_tag]
    end

    it "assigns to root tags" do
      expect(assigns[:root_tags]).to eq [root_tag]
    end
  end

  describe "#show" do
    let(:tag) { create :tag }

    it "finds the right tag" do
      get :show, id: tag.id
      expect(assigns[:tag]).to eq tag
    end

    it "renders the right template" do
      get :show, id: tag.id
      expect(response).to render_template(partial: "show", locals: { tag: tag })
    end

    context "with a non existing id" do
      before do
        allow(tag).to receive(:id) { 2_000 }
      end

      it "breaks nicely" do
        get :show, id: tag.id
        expect(response.status).to eq 404
      end
    end
  end

  describe "#new" do
    it "builds a new tag with the right params" do
      get :new, tag: { hierarchical: true }
      expect(assigns[:tag]).to be_a Pulitzer::Tag
      expect(assigns[:tag].new_record?).to eq true
      expect(assigns[:tag].hierarchical?).to eq true
    end

    context "with hierarchical: true" do
      it "responds with the right template" do
        get :new, tag: { hierarchical: true }
        expect(response).to render_template('_new_hierarchical')
      end

    end

    context "with hierarchical: false" do
      it "responds with the right template" do
        get :new, tag: { hierarchical: false }
        expect(response).to render_template('_new_flat')
      end
    end
  end

  describe "#create" do
    pending
  end

  describe "#edit" do
    pending
  end

  describe "#destroy" do
    pending
  end
end
