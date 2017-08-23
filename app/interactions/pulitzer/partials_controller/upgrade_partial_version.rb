class Pulitzer::PartialsController::UpgradePartialVersion

  def initialize(partial)
    @partial            = partial
    @free_form_section  = partial.free_form_section
  end

  def call
    most_recent_partial_version = @partial.post_type_version.post_type.most_recent_published_post_type_version
    new_partial = @free_form_section.partials.create(label: @partial.label, post_type_version_id: most_recent_partial_version.id,
      sort_order: @partial.sort_order)
    Pulitzer::CreatePartialContentElements.new(new_partial).call
    content_elements = new_partial.reload.content_elements.to_a
    content_elements.each_with_index do |ce, index|
      old_ce = @partial.content_elements.find_by(label: ce.label)
      if old_ce
        cloned = old_ce.clone_me
        new_partial.content_elements << cloned
        cloned.update(post_type_content_element_type_id: ce.post_type_content_element_type_id, partial_id: ce.partial_id,
                      version_id: ce.version_id, sort_order: index)
        ce.destroy!
      end
    end
    @partial.destroy!
    new_partial.reload
  end
end
