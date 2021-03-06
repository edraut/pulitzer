require 'rails_helper'

describe Pulitzer::VersionsController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:post_type) { Pulitzer::PostType.named('Welcome') }
  let(:post_type_version) {post_type.published_type_version}
  let(:content_element_type) { post_type_version.post_type_content_element_types.first.content_element_type }
  let(:ppost) { post_type_version.posts.first }
  let(:version) {ppost.preview_version}

  describe "updating versions", type: :request do
    it "abandons a post that was never published" do
      active_version = ppost.active_version
      active_version.destroy
      old_post_id = version.post.id
      patch pulitzer.version_path id: version.id, status: 'abandoned'
      expect(response.status).to eq 200
      expect(Pulitzer::Version.find_by(id: version.id)).to eq nil
      expect(Pulitzer::Post.find_by(id: old_post_id)).to eq nil
      expect(response.body).to match "hooch.ReloadPage"
    end

    it "abandons a post that was published" do
      Pulitzer::UpdateVersionStatus.new(version, 'active').call
      expect(version.status).to eq 'active'
      expect(version.post.active_version).not_to be_nil
      patch pulitzer.version_path id: version.id, status: 'abandoned'
      expect(response.status).to eq 200
      expect(version.reload.status).to eq 'abandoned'
      expect(version.post.active_version).to be_nil
    end

    it "abandons changes" do
      Pulitzer::UpdateVersionStatus.new(version, 'active').call
      active_version = version
      expect(active_version.status).to eq 'active'
      old_preview = version.post.preview_version
      patch pulitzer.version_path id: old_preview.id, status: 'abandoned'
      expect(response.status).to eq 200
      expect(active_version.reload.status).to eq 'active'
      expect(old_preview.reload.status).to eq 'abandoned'
    end

    it "responds with errors if the interaction has one" do
      main_content = post_type_version.free_form_section_types.find_by(name: "Main Content")
      text_section = Pulitzer::PostType.named('Text Section').published_type_version
      main_content.partial_types.create(post_type_version_id: text_section.id)
      ptcet = post_type_version.post_type_content_element_types.create(label: 'test', required: true, content_element_type: content_element_type)
      required_element = version.content_elements.first
      required_element.update_columns(body: nil, post_type_content_element_type_id: ptcet.id)
      patch pulitzer.version_path id: version.id, status: 'active'
      expect(response.status).to eq 409
      expect(response.body).to match "#{required_element.label} is required"
      expect(response.body).to match Regexp.new("#{main_content.name} -.* #{text_section.name} is required")
    end
  end
end