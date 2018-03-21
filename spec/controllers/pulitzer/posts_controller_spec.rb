require 'rails_helper'

describe Pulitzer::PostsController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.named('Welcome') }
  let(:post_type_version) {post_type.published_type_version}
  let(:ppost) {post_type_version.singleton_post}

  describe "post crud", type: :request do
    it "edits a post" do
      get pulitzer.edit_post_path id: ppost.id
      expect(response.status).to eq 200
      assert_select 'h1', "Editing #{ppost.title}"
    end

    it "edits a post title" do
      get pulitzer.edit_title_post_path(ppost)
      expect(response.status).to eq 200
      assert_select 'input[name="post[title]"]'
    end

    it "shows a processing version if the preview version failed to be generated previously" do
      allow_any_instance_of(Pulitzer::CloneVersionJob).to receive(:perform) { true }
      ppost.preview_version.destroy
      get pulitzer.edit_post_path id: ppost.id
      expect(response.status).to eq 200
      assert_select 'h2', "Processing Preview for #{ppost.reload.processing_version.title}"
    end
  end
end
