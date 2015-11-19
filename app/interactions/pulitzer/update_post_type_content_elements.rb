class Pulitzer::UpdatePostTypeContentElements
  attr_accessor :post_type, :ptcet, :old_label

  def initialize(ptcet, old_label=nil)
    self.post_type  = ptcet.post_type
    self.ptcet      = ptcet
    self.old_label  = old_label || ptcet.label
  end

  def call
    post_type.posts.each do |post|
      post.preview_version.content_elements.where(label: old_label).each do |content_element|
        content_element.update(label: ptcet.label,
          height: ptcet.height,
          width: ptcet.width,
          text_editor: ptcet.text_editor,
          content_element_type: ptcet.content_element_type,
          post_type_content_element_type: ptcet)
      end
    end
  end
end
