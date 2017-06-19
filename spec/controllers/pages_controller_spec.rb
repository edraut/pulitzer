require 'rails_helper'

describe PagesController do
  describe "#welcome", type: :request do

    it "renders the welcome page" do
      post_type_version = Pulitzer::PostType.named('Welcome').published_type_version
      version = post_type_version.posts.find_by!(slug: 'welcome').get_active_version!
      ffs = version.free_form_sections.find_by name: 'Main Content'
      partial_type = Pulitzer::PostType.create(name: 'partial with no display', kind: Pulitzer::PostType.kinds[:partial], plural: false)
      partial_type_version = partial_type.post_type_versions.create(status: :published)
      ffs.partials.create(post_type_version_id: partial_type_version.id)
      get welcome_path slug: 'welcome'
      expect(response.status).to eq 200
    end

  end
end
