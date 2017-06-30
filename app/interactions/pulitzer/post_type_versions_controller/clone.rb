class Pulitzer::PostTypeVersionsController::Clone

  def initialize(params)
    @params = params.to_h.to_hash.symbolize_keys
  end

  def call
    new_post_type_version = Pulitzer::PostTypeVersionsController::Create.new(@params, false).call
    published_type_version = new_post_type_version.post_type.published_type_version
    cloning_errors = []
    new_post_type_version.processed_element_count = 0
    published_type_version.post_type_content_element_types.each do |ptcet|
      begin
        new_post_type_version.post_type_content_element_types << ptcet.clone_me
      rescue ActiveRecord::RecordInvalid => invalid
        cloning_errors.push "PostType Content Element Type #{ptcet.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
      end
      new_post_type_version.processed_element_count += 1
      new_post_type_version.broadcast_change if defined? ForeignOffice
    end
    if new_post_type_version.kind == 'partial'
      published_type_version.background_styles.each do |bs|
        begin
          new_post_type_version.background_styles << bs.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          cloning_errors.push "Background Styles #{bs.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
        end
        new_post_type_version.processed_element_count += 1
        new_post_type_version.broadcast_change if defined? ForeignOffice
      end
      published_type_version.justification_styles.each do |js|
        begin
          new_post_type_version.justification_styles << js.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          cloning_errors.push "Justification Styles #{js.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
        end
        new_post_type_version.processed_element_count += 1
        new_post_type_version.broadcast_change if defined? ForeignOffice
      end
      published_type_version.sequence_flow_styles.each do |sfs|
        begin
          new_post_type_version.sequence_flow_styles << sfs.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          cloning_errors.push "Sequence Flow Styles #{sfs.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
        end
        new_post_type_version.processed_element_count += 1
        new_post_type_version.broadcast_change if defined? ForeignOffice
      end
      published_type_version.arrangement_styles.each do |as|
        begin
          new_post_type_version.arrangement_styles << as.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          cloning_errors.push "Arrangement Styles #{as.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
        end
        new_post_type_version.processed_element_count += 1
        new_post_type_version.broadcast_change if defined? ForeignOffice
      end
    elsif new_post_type_version.kind == 'template'
      published_type_version.free_form_section_types.each do |ffst|
        begin
          new_post_type_version.free_form_section_types << ffst.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          cloning_errors.push "Free Form Section Type #{ffst.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
        end
        new_post_type_version.processed_element_count += 1
        new_post_type_version.broadcast_change if defined? ForeignOffice
      end
      published_type_version.posts.each do |post|
        Pulitzer::PostTypeVersionsController::ClonePostWithVersionElements.new(post, new_post_type_version).call
      end
    end
    new_post_type_version
  end

end
