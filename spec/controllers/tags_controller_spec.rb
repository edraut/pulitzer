require 'rails_helper'

describe Pulitzer::TagsController do

  routes { Pulitzer::Engine.routes }

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
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
