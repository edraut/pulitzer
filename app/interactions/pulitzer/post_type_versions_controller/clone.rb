class Pulitzer::PostTypeVersionsController::Clone

  def initialize(params)
    @params = params.to_h.to_hash.symbolize_keys
  end

  def call
    new_version = Pulitzer::PostTypeVersionsController::Create.new(@params).call
    published_type_version = new_version.post_type.published_type_version
    cloning_errors = []
    new_version.processed_element_count = 0
    published_type_version.post_type_content_element_types.each do |ptcet|
      begin
        new_version.post_type_content_element_types << ptcet.clone_me
      rescue ActiveRecord::RecordInvalid => invalid
        cloning_errors.push "PostType Content Element Type #{ptcet.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
      end
      new_version.processed_element_count += 1
      new_version.broadcast_change if defined? ForeignOffice
    end
    published_type_version.free_form_section_types.each do |ffst|
      begin
        new_version.free_form_section_types << ffst.clone_me
      rescue ActiveRecord::RecordInvalid => invalid
        cloning_errors.push "Free Form Section Type #{ffst.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
      end
      new_version.processed_element_count += 1
      new_version.broadcast_change if defined? ForeignOffice
    end
    new_version
  end

end
