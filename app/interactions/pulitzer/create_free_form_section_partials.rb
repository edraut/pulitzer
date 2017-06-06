class Pulitzer::CreateFreeFormSectionPartials

  def initialize(partial_type)
    @partial_type = partial_type
  end

  def call
    free_form_section_type  = @partial_type.free_form_section_type
    post_type_version       = free_form_section_type.post_type_version
    post_type_version.posts.each do |post|
      if post.preview_version
        free_form_section = post.preview_version.free_form_sections.find_by(name: free_form_section_type.name)
        partial = free_form_section.partials.create do |p|
          p.label         = @partial_type.label
          p.sort_order    = @partial_type.sort_order
          p.post_type_id  = @partial_type.post_type_id
          p.layout_id      = @partial_type.layout_id
        end
        Pulitzer::CreatePartialContentElements.new(partial).call
      end
    end
  end
end
