require 'rails_helper'

describe Pulitzer::VersionsController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:version) {create(:version, :with_content_elements)}

  describe "updating versions" do
    it "abandons a post that was never published" do
      old_post_id = version.post.id
      patch :update, id: version.id, status: 'abandoned'
      expect(response.status).to eq 200
      expect(Pulitzer::Version.find_by(id: version.id)).to eq nil
      expect(Pulitzer::Post.find_by(id: old_post_id)).to eq nil
      expect(response.body).to match "hooch.ReloadPage"
    end

    it "abandons a post that was published" do
      Pulitzer::UpdateVersionStatus.new(version, 'active').call
      expect(version.status).to eq 'active'
      expect(version.post.active_version).not_to be_nil
      patch :update, id: version.id, status: 'abandoned'
      expect(response.status).to eq 200
      expect(version.reload.status).to eq 'abandoned'
      expect(version.post.active_version).to be_nil
    end

    it "abandons changes" do
      Pulitzer::UpdateVersionStatus.new(version, 'active').call
      active_version = version
      expect(active_version.status).to eq 'active'
      old_preview = version.post.preview_version
      patch :update, id: old_preview.id, status: 'abandoned'
      expect(response.status).to eq 200
      expect(active_version.reload.status).to eq 'active'
      expect(old_preview.reload.status).to eq 'abandoned'
      expect(active_version.post.preview_version.status).to eq 'preview'
      expect(version.post.preview_version.id).not_to eq old_preview.id
    end
  end
end