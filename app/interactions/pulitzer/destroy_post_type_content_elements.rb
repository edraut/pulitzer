class Pulitzer::DestroyPostTypeContentElements
  attr_accessor :post_type, :ptcet

  def initialize(ptcet)
    self.post_type  = ptcet.post_type
    self.ptcet      = ptcet
  end

  def call
    post_type.posts.each do |post|
      post.content_elements.where(label: ptcet.label).each do |ce|
        ce.destroy
      end
    end
  end
end
