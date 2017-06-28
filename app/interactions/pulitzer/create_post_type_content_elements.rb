class Pulitzer::CreatePostTypeContentElements
  attr_accessor :post_type_version, :ptcet, :old_label

  def initialize(ptcet)
    self.post_type_version  = ptcet.post_type_version
    self.ptcet              = ptcet
  end

  def call
    post_type_version.posts.each do |post|
      post.preview_version.content_elements.create do |ce|
        ce.label                          = ptcet.label
        ce.height                         = ptcet.height
        ce.width                          = ptcet.width
        ce.text_editor                    = ptcet.text_editor
        ce.content_element_type           = ptcet.content_element_type
        ce.post_type_content_element_type = ptcet
      end
    end
  end
end
