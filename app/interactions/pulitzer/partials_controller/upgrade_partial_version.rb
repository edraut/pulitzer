class Pulitzer::PartialsController::UpgradePartialVersion

  def initialize(partial)
    @partial            = partial
    @free_form_section  = partial.free_form_section
  end

  def call
    most_recent_partial_version = @partial.post_type_version.post_type.most_recent_post_type_version
    new_partial = @free_form_section.partials.create(label: @partial.label, post_type_version_id: most_recent_partial_version.id)
    Pulitzer::CreatePartialContentElements.new(new_partial).call
    new_partial
  end
end
