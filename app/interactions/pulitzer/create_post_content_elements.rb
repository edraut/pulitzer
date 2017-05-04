class Pulitzer::CreatePostContentElements
  attr_accessor :post

  def initialize(post)
    self.post = post
  end

  def call
    post.post_type_content_element_types.each do |cet|
      post.preview_version.content_elements.create do |ce|
        ce.label                          = cet.label
        ce.height                         = cet.height
        ce.width                          = cet.width
        ce.text_editor                    = cet.text_editor
        ce.content_element_type           = cet.content_element_type
        ce.post_type_content_element_type = cet
      end
    end
    post.free_form_section_types.each do |ffst|
      post.preview_version.free_form_sections.create name: ffst.name, free_form_section_type_id: ffst.id
    end
  end
end
