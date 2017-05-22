require 'rails_helper'

describe Pulitzer::TagsController do

  routes { Pulitzer::Engine.routes }
  render_views

  describe "#index", type: :request do
    let!(:flat_tag) { create :tag, hierarchical: false }
    let!(:root_tag) { create :tag, hierarchical: true  }

    before { get pulitzer.tags_path }

    it "renders the index template" do
      expect(response).to render_template("_index")
    end

    it "renders flat tags" do
      expect(response.body).to match(flat_tag.name)
    end

    it "renders root tags" do
      expect(response.body).to match(root_tag.name)
    end
  end

  describe "#show", type: :request do
    let(:tag) { create :tag }

    it "finds the right tag" do
      get pulitzer.tag_path id: tag.id
      expect(response.body).to match(tag.name)
    end

    it "renders the right template" do
      get pulitzer.tag_path id: tag.id
      expect(response).to render_template(partial: "show", locals: { tag: tag })
    end
  end

  describe "#new", type: :request do
    it "builds a new tag with the right params" do
      get pulitzer.new_tag_path tag: { hierarchical: true }
      expect(response).to have_http_status(:success)
      expect(response.body).to match('tag\[name\]')
    end

    context "with hierarchical: true" do
      it "responds with the right template" do
        get pulitzer.new_tag_path tag: { hierarchical: true }
        expect(response).to render_template('_new_hierarchical')
      end

    end

    context "with hierarchical: false" do
      it "responds with the right template" do
        get pulitzer.new_tag_path tag: { hierarchical: false }
        expect(response).to render_template('_new_flat')
      end
    end
  end

  describe "#create", type: :request do
    let(:attributes) { attributes_for :tag }
    context "with good arguments" do

      it "creates the tag" do
        expect { post pulitzer.tags_path tag: attributes }.to change { Pulitzer::Tag.count }.by(1)
      end

      it "renders the right template" do
        post pulitzer.tags_path tag: attributes
        expect(response).to render_template('_show_wrapper')
      end
    end

    context "with bad arguments" do
      let!(:tag1) { create :tag, name: "awesomesauce" }

      before do
        attributes.merge! name: "awesomesauce"
      end

      it "doesn't save the tag" do
        expect { post pulitzer.tags_path tag: attributes }.not_to change { Pulitzer::Tag.count }
      end

      it "renders the right template" do
        post pulitzer.tags_path tag: attributes
        expect(response).to render_template("_new_flat")
      end
    end
  end

  describe "#edit", type: :request do
    let(:tag) { create :tag }

    it "finds the right tag" do
      get pulitzer.edit_tag_path id: tag.id
      expect(response.body).to match(tag.name)
    end

    it "renders the right template" do
      get pulitzer.edit_tag_path id: tag.id
      expect(response).to render_template("_form")
    end
  end

  describe "#update", type: :request do
    routes { Pulitzer::Engine.routes }
    let(:tag) { create :tag }
    let(:attributes) { attributes_for :tag }

    context "with good arguments" do

      before do
        allow(Pulitzer::Tag).to receive(:find) { tag }
      end

      it "updates the record" do
        expect(tag).to receive(:update_attributes)
        patch tag_path(id: tag.id, tag: attributes)
      end

      it "renders the right response" do
        patch tag_path(id: tag.id, tag: attributes)
        expect(response).to render_template("_show")
      end
    end

    context "with bad arguments" do
      before do
        create :tag, name: "sadpanda"
        attributes.merge! name: "sadpanda"
        allow(Pulitzer::Tag).to receive(:find) { tag }
        patch tag_path( id: tag.id, tag: attributes)
      end

      it "doesn't update the record" do
        expect(response.body).to match("Name has already been taken")
      end

      it "renders the right template" do
        expect(response).to render_template("_form")
      end
    end
  end

  describe "#destroy", type: :request do
    let(:tag) { create :tag }
    render_views

    before { allow(Pulitzer::Tag).to receive(:find) { tag} }

    it "destroys the record" do
      expect(tag).to receive(:destroy)
      delete pulitzer.tag_path id: tag.id
    end

    it "renders nothing" do
      delete pulitzer.tag_path id: tag.id
      expect(response.body).to eq ""
    end
  end
end
