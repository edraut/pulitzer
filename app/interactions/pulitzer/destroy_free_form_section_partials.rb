class Pulitzer::DestroyFreeFormSectionPartials

  def initialize(partial_type)
    @partial_type = partial_type
  end

  def call
    free_form_section_type  = @partial_type.free_form_section_type
    post_type               = free_form_section_type.post_type
    post_type.posts.each do |post|
      if post.preview_version
        free_form_section = post.preview_version.free_form_sections.find_by(name: free_form_section_type.name)
        partial = free_form_section.partials.find_by(label: @partial_type.label)&.destroy
      end
    end
  end
end
