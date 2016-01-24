class Pulitzer::CloneVersion
  include Pulitzer::Engine.routes.url_helpers

  def initialize(version)
    @version = version
    @post = @version.post
    Rails.logger.info("Pulitzer::CloneVersion !!! ")
    Rails.logger.info($0)
  end

  def call
    new_version = @post.processing_version
    cloning_errors = []
    new_version.processed_element_count = 0
    @version.content_elements.each do |ce|
      begin
        cloned_content_element = ce.clone_me
        new_version.content_elements << cloned_content_element
      rescue ActiveRecord::RecordInvalid => invalid
        cloning_errors.push "ContentElement #{ce.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
      end
      new_version.processed_element_count += 1
      new_version.broadcast_change
    end
    @version.post_tags.each do |pt|
      new_version.post_tags << pt.clone_me
      new_version.processed_element_count += 1
      new_version.broadcast_change
    end
    if cloning_errors.any?
      new_version.update(status: :processing_failed, cloning_errors: cloning_errors)
    else
      new_version.update(status: :preview)
      new_version.processed_element_count += 1
      new_version.broadcast_change
    end
    @post.new_preview_version = edit_version_path(new_version)
    new_version.processed_element_count += 1
    new_version.broadcast_change
    @post.broadcast_change
    new_version
  end

end
