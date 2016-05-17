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
    pending
  end

  describe "#new" do
    pending
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
