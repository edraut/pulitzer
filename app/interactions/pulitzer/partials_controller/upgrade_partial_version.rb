class Pulitzer::PartialsController::UpgradePartialVersion

  def initialize(partial)
    @partial            = partial
    @free_form_section  = partial.free_form_section
  end

  def call
    most_recent_partial_version = @partial.post_type_version.post_type.most_recent_post_type_version
    new_partial = @free_form_section.partials.create(label: @partial.label, post_type_version_id: most_recent_partial_version.id)
    Pulitzer::CreatePartialContentElements.new(new_partial).call
    content_elements = new_partial.content_elements.to_a
    content_elements.each do |ce|
      old_ce = @partial.content_elements.find_by(label: ce.label)
      if old_ce
        cloned = old_ce.clone_me
        cloned.update(post_type_content_element_type_id: ce.post_type_content_element_type_id, partial_id: ce.partial_id)
        ce.destroy
      end
    end
    @partial.destroy
    new_partial
  end
end
