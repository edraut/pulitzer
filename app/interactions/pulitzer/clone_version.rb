class Pulitzer::CloneVersion

  def initialize(version)
    @version = version
    @post = @version.post
  end

  def call
    new_version = @post.create_processing_version
    @version.content_elements.each do |ce|
      begin
        cloned_content_element = ce.clone_me
        new_version.content_elements << cloned_content_element
      rescue ActiveRecord::RecordInvalid => invalid
        new_version.errors.add(:base, "ContentElement #{ce.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}")
      end
    end
    @version.post_tags.each do |pt|
      new_version.post_tags << pt.clone_me
    end
    new_version.update(status: :preview)
    new_version
  end

end
