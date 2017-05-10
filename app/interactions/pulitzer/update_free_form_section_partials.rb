class Pulitzer::UpdateFreeFormSectionPartials

  def initialize(partial_type, old_label)
    @partial_type, @old_label = partial_type, old_label
  end

  def call
    free_form_section_type  = @partial_type.free_form_section_type
    post_type               = free_form_section_type.post_type
    post_type.posts.each do |post|
      if post.preview_version
        free_form_section = post.preview_version.free_form_sections.find_by(name: free_form_section_type.name)
        partial = free_form_section.partials.find_by(label: @old_label)
        partial.update(label: @partial_type.label, layout_id: @partial_type.layout_id) if partial
      end
    end
  end
end
