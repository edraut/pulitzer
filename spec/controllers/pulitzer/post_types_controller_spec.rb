require 'rails_helper'

describe Pulitzer::PostTypesController do
  routes { Pulitzer::Engine.routes }
  render_views
  let(:post_type){Pulitzer::PostType.first}

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

    it "exports a post type" do
      get pulitzer.export_post_type_path id: post_type.id
      expect(response.status).to eq 200
      response_json = JSON.parse(response.body)
      expect(response_json['name']).to eq post_type.name
      expect(response_json['plural']).to eq post_type.plural
      expect(response_json['kind']).to eq post_type.kind
      expect(response_json["post_type_versions_attributes"].length).to eq post_type.post_type_versions.length
    end

  end
end
