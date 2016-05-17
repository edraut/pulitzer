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
    let(:attributes) { attributes_for :tag }
    context "with good arguments" do

      it "creates the tag" do
        expect { post :create, tag: attributes }.to change { Pulitzer::Tag.count }.by(1)
      end

      it "renders the right template" do
        post :create, tag: attributes
        expect(response).to render_template('_show_wrapper')
      end
    end

    context "with bad arguments" do
      let!(:tag1) { create :tag, name: "awesomesauce" }

      before do
        attributes.merge! name: "awesomesauce"
      end

      it "doesn't save the tag" do
        expect { post :create, tag: attributes }.not_to change { Pulitzer::Tag.count }
      end

      it "renders the right template" do
        post :create, tag: attributes
        expect(response).to render_template("_new_flat")
      end
    end
  end

  describe "#edit" do
    let(:tag) { create :tag }

    it "finds the right tag" do
      get :edit, id: tag.id
      expect(assigns[:tag]).to eq tag
    end

    it "renders the right template" do
      get :edit, id: tag.id
      expect(response).to render_template("_form")
    end
  end

  describe "#update" do
    let(:tag) { create :tag }
    let(:attributes) { attributes_for :tag }

    context "with good arguments" do

      before do
        allow(Pulitzer::Tag).to receive(:find) { tag }
      end

      it "updates the record" do
        expect(tag).to receive(:update_attributes).with(attributes)
        patch :update, id: tag.id, tag: attributes
      end

      it "renders the right response" do
        patch :update, id: tag.id, tag: attributes
        expect(response).to render_template("_show")
      end
    end

    context "with bad arguments" do
      before do
        create :tag, name: "sadpanda"
        attributes.merge! name: "sadpanda"
        allow(Pulitzer::Tag).to receive(:find) { tag }
        patch :update, id: tag.id, tag: attributes
      end

      it "doesn't update the record" do
        expect(assigns[:tag].errors).not_to be_empty
      end

      it "renders the right template" do
        expect(response).to render_template("_form")
      end
    end
  end

  describe "#destroy" do
    let(:tag) { create :tag }
    render_views

    before { allow(Pulitzer::Tag).to receive(:find) { tag} }

    it "destroys the record" do
      expect(tag).to receive(:destroy)
      delete :destroy, id: tag.id
    end

    it "renders nothing" do
      delete :destroy, id: tag.id
      expect(response.body).to eq ""
    end
  end
end
