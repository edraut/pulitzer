class Pulitzer::DestroyPostTypeContentElements
  attr_accessor :post_type_version, :ptcet

  def initialize(ptcet)
    self.post_type_version  = ptcet.post_type_version
    self.ptcet      = ptcet
  end

  def call
    post_type_version.posts.each do |post|
      post.preview_version.content_elements.where(label: ptcet.label).each do |ce|
        ce.destroy
      end
    end
  end
end
