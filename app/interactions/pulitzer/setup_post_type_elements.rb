class Pulitzer::SetupPostTypeElements
  attr_accessor :post_type, :ptcet, :old_label

  def initialize(ptcet, old_label=nil)
    self.post_type  = ptcet.post_type
    self.ptcet      = ptcet
    self.old_label  = old_label || ptcet.label
  end

  def create
    post_type.posts.each do |post|
      post.content_elements.create do |ce|
        ce.label = ptcet.label
        ce.content_element_type = ptcet.content_element_type
      end
    end
  end

  def update
    post_type.posts.each do |post|
      post.content_elements.where(label: old_label).each do |ce|
        ce.update(label: ptcet.label, content_element_type: ptcet.content_element_type)
      end
    end
  end
end
