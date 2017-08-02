class Pulitzer::PartialsController::UpgradePartialVersion

  def initialize(partial)
    @partial            = partial
    @free_form_section  = partial.free_form_section
  end

  def call
    most_recent_partial_version = @partial.post_type_version.post_type.most_recent_published_post_type_version
    new_partial = @free_form_section.partials.create(label: @partial.label, post_type_version_id: most_recent_partial_version.id)
    clone_styles(@partial,new_partial)
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
    @partial.remove_show = true
    @partial.broadcast_change if defined? ForeignOffice
    @partial.destroy

    new_partial.reload_show = true
    new_partial.broadcast_change if defined? ForeignOffice
    new_partial
  end

  def clone_styles(old_partial,new_partial)
    old_arrangement_style = old_partial.arrangement_style
    old_justification_style = old_partial.justification_style
    old_background_style = old_partial.background_style
    old_sequence_flow_style = old_partial.sequence_flow_style
    new_arrangement_styles = new_partial.post_type_version.arrangement_styles.to_a
    new_justification_styles = new_partial.post_type_version.justification_styles.to_a
    new_background_styles = new_partial.post_type_version.background_styles.to_a
    new_sequence_flow_styles = new_partial.post_type_version.sequence_flow_styles.to_a
    if old_arrangement_style.present?
      new_style = new_arrangement_styles.detect do |style|
        old_arrangement_style.view_file_name == style.view_file_name
      end
      if new_style.present?
        new_partial.arrangement_style_id = new_style.id
      end
    end
    if old_justification_style.present?
      new_style = new_justification_styles.detect do |style|
        old_justification_style.css_class_name == style.css_class_name
      end
      if new_style.present?
        new_partial.justification_style_id = new_style.id
      end
    end
    if old_background_style.present?
      new_style = new_background_styles.detect do |style|
        old_background_style.css_class_name == style.css_class_name
      end
      if new_style.present?
        new_partial.background_style_id = new_style.id
      end
    end
    if old_sequence_flow_style.present?
      new_style = new_sequence_flow_styles.detect do |style|
        old_sequence_flow_style.css_class_name == style.css_class_name
      end
      if new_style.present?
        new_partial.sequence_flow_style_id = new_style.id
      end
    end
    new_partial.save
  end
end
