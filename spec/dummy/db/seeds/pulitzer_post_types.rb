module Seeds
  module PulitzerPostTypes
    def self.create
      welcome_post_type = Pulitzer::PostType.create( name: "Welcome", plural: true, kind: :template)
      post_type_version = welcome_post_type.post_type_versions.create(status: :published)
      content_element_type = Pulitzer::ContentElementType.create(name: 'Text')
      image_element_type = Pulitzer::ContentElementType.create(name: 'Image')
      video_element_type = Pulitzer::ContentElementType.create(name: 'Video')
      clickable_element_type = Pulitzer::ContentElementType.create(name: 'Clickable')

      content_elements = [
        { label: 'Hero Title 1', content_element_type_id: content_element_type.id },
        { label: 'Hero Title 2', content_element_type_id: content_element_type.id },
        { label: 'Hero Title 3', content_element_type_id: content_element_type.id },
        { label: 'Guest Title', content_element_type_id: content_element_type.id },
        { label: 'Guest Text', content_element_type_id: content_element_type.id },
        { label: 'Footer Title', content_element_type_id: content_element_type.id },
        { label: 'Footer Text', content_element_type_id: content_element_type.id },
        { label: 'Metadata title', content_element_type_id: content_element_type.id },
        { label: 'Metadata description', content_element_type_id: content_element_type.id },
        { label: 'Metadata keywords', content_element_type_id: content_element_type.id },
        { label: 'Call to Action Button', content_element_type_id: clickable_element_type.id }
      ]

      content_elements.each do |ce|
        post_type_version.post_type_content_element_types.create ce
      end

      free_forms = [{name: "Main Content"}, {name: "Handpicked Homes"}]
      free_forms.each{|ff| post_type_version.free_form_section_types.create(ff)}

      welcome_post = Pulitzer::Post.create( title: "Welcome", post_type_version: post_type_version )
      welcome_post.create_preview_version
      
      Pulitzer::CreatePostContentElements.new(welcome_post).call

      travel_guide_post_type = Pulitzer::PostType.create( name: "Travel Guides", plural: true, kind: :template)
      tg_version = travel_guide_post_type.post_type_versions.create(status: :published)
      travel_guide = tg_version.posts.create( title: 'Complete Guide to Breckenridge')

      travel_article_post_type = Pulitzer::PostType.create( name: "Travel Articles", plural: true, kind: :template)
      ta_version = travel_article_post_type.post_type_versions.create(status: :published)
      travel_article = ta_version.posts.create( title: 'Ski Jump Competition')

      external_article_post_type = Pulitzer::PostType.create( name: "External Articles", plural: true, kind: :template)
      ea_version = external_article_post_type.post_type_versions.create(status: :published)
      external_article = ea_version.posts.create( title: 'Why visit Breckenridge')

      #publish the welcome post
      welcome_post = Pulitzer::Post.find_by title: "Welcome"
      Pulitzer::UpdateVersionStatus.new(welcome_post.preview_version, :active).call
      welcome_post.content_elements.each do |ce|
        ce.update(body: ce.label)
      end

      col = Pulitzer::CustomOptionList.create name: 'Sliders'
      co = col.custom_options.create(display: 'Rental Estimate', value: 'contactMgmt')
      co2 = col.custom_options.create(display: 'Agent Coterie', value: 'contactRealEstate')
    end
  end
end
