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
    begin
      @new_active_version.update!(status: :active)
    rescue ActiveRecord::RecordInvalid => invalid
      Rails.logger.error(invalid.record.errors.messages.to_s)
    end
    @new_active_version.tags.each &:touch
    @old_active_version.update(status: :archived) if @old_active_version
    @processing_version = @post.create_processing_version
    Pulitzer::CloneVersionJob.perform_later(@new_active_version)
    instance_eval(&Pulitzer.publish_callback) unless Pulitzer.skip_publish_callback?
    @post.reload
    @processing_version.reload
  end

  def make_version_abandoned
    @active_version = @transitional_version.post.active_version
    @transitional_version.update(status: :abandoned)
    if @active_version == @transitional_version
      @transitional_version.post.preview_version
      instance_eval(&Pulitzer.publish_callback) unless Pulitzer.skip_publish_callback?
    else
      @processing_version = @post.create_processing_version
      Pulitzer::CloneVersionJob.perform_later(@active_version)
      @processing_version
    end
  end

end
