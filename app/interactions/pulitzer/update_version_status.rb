class Pulitzer::UpdateVersionStatus
  attr_accessor :errors

  def initialize(version, status)
    @errors = []
    @transitional_version = version
    @status = status
    @status_change_method = 'make_version_' + @status.to_s
    if @status == "active" && version.empty_required_content_elements?
      @processing_version = version
      @errors = ["It's not possible to activate a version without filling required content elements"]
    end
    @post = version.post
  end

  def call
    unless @errors.any?
      send @status_change_method
    end
    @processing_version
  end

  def make_version_active
    @new_active_version = @transitional_version
    @old_active_version = @new_active_version.post.active_version
    @new_active_version.update(status: :active)
    if @new_active_version.errors.any?
      @new_active_version.update(status: :processing_failed, cloning_errors: @new_active_version.errors.full_messages)
      @processing_version = @new_active_version
    else
      @new_active_version.tags.each &:touch
      @old_active_version.update(status: :archived) if @old_active_version
      @processing_version = @post.create_processing_version
      Pulitzer::CloneVersionJob.perform_later(@new_active_version)
      instance_eval(&Pulitzer.publish_callback) unless Pulitzer.skip_publish_callback?
    end
    @post.reload
    @processing_version.reload
  end

  def make_version_abandoned
    @active_version = @transitional_version.post.active_version
    @transitional_version.update(status: :abandoned)
    @transitional_version.tags.each &:touch
    if @active_version.is_a? Pulitzer::Version
      if @active_version == @transitional_version
        @processing_version = @transitional_version.post.preview_version
        instance_eval(&Pulitzer.publish_callback) unless Pulitzer.skip_publish_callback?
      else
        @processing_version = @post.create_processing_version
        Pulitzer::CloneVersionJob.perform_later(@active_version)
        @processing_version
      end
    else # There is no active version, we never published this one
      @processing_version = @transitional_version
    end
    @transitional_version
  end

end
