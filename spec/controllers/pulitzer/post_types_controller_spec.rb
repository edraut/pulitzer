require 'rails_helper'

describe Pulitzer::PostTypesController do
  routes { Pulitzer::Engine.routes }
  render_views

  describe "#create", type: :request do
    it "Creates a plural post type without an intial post" do
      post pulitzer.post_types_path post_type: { name: 'Flock of birds', kind: 'template', plural: '1' }
      expect(response.status).to eq 200
      expect(response.body).to match /Flock of birds/
      post_type = Pulitzer::PostType.find_by(name: 'Flock of birds')
      post_type_version = post_type.post_type_versions.first
      expect(post_type_version.posts.any?).to be false
    end

    it "Creates a single post type with an intial post" do
      post pulitzer.post_types_path post_type: { name: 'Crow', kind: 'template', plural: '0' }
      post_type = Pulitzer::PostType.find_by(name: 'Crow')
      post_type_version = post_type.post_type_versions.first
      expect(response.status).to eq 200
      expect(response.body).to match post_type_version.name
      expect(post_type_version.posts.count).to eq 1
      expect(post_type_version.posts.first.title).to eq post_type_version.name
    end
  end
end
