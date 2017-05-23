require 'rails_helper'

describe Pulitzer::PostTypesController do
  routes { Pulitzer::Engine.routes }
  render_views

  describe "#create", type: :request do
    it "Creates a plural post type without an intial post" do
      post pulitzer.post_types_path post_type: { name: 'Flock of birds', kind: 'template', plural: '1' }
      expect(response.status).to eq 200
      expect(response.body).to match /Flock of birds/
      expect(Pulitzer::PostType.find_by(name: 'Flock of birds').posts.any?).to be false
    end

    it "Creates a single post type with an intial post" do
      post pulitzer.post_types_path post_type: { name: 'Crow', kind: 'template', plural: '0' }
      post_type = Pulitzer::PostType.find_by(name: 'Crow')
      expect(response.status).to eq 200
      expect(response.body).to match post_type.name
      expect(post_type.posts.count).to eq 1
      expect(post_type.posts.first.title).to eq post_type.name
    end
  end
end
