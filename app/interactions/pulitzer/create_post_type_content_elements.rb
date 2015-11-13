class Pulitzer::CreatePostTypeContentElements
  attr_accessor :post_type, :ptcet, :old_label

  def initialize(ptcet)
    self.post_type  = ptcet.post_type
    self.ptcet      = ptcet
  end

  def call
    post_type.posts.each do |post|
      post.preview_version.content_elements.create do |ce|
        ce.label = ptcet.label
        ce.content_element_type = ptcet.content_element_type
        ce.post_type_content_element_type = ptcet
      end
    end
  end
end
