class Pulitzer::SetupPostElements
  attr_accessor :post

  def initialize(post)
    self.post = post
  end

  def call
    post.post_type_content_element_types.each do |cet|
      post.content_elements.create do |ce|
        ce.label = cet.label
        ce.content_element_type = cet.content_element_type
      end
    end
  end
end
