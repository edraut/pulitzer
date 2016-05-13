class Pulitzer::CreatePartialContentElements
  attr_accessor :partial

  def initialize(partial)
    self.partial = partial
  end

  def call
    partial.post_type_content_element_types.each do |cet|
      partial.content_elements.create do |ce|
        ce.label                          = cet.label
        ce.height                         = cet.height
        ce.width                          = cet.width
        ce.text_editor                    = cet.text_editor
        ce.content_element_type           = cet.content_element_type
        ce.post_type_content_element_type = cet
      end
    end
  end
end
