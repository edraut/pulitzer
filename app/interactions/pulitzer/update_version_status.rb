class Pulitzer::UpdateVersionStatus
  def initialize(version, status)
    @transitional_version = version
    @status = status
    @status_change_method = 'make_version_' + @status.to_s
    @post = version.post
  end

  def call
    send @status_change_method
  end

  def make_version_active
    @new_active_version = @transitional_version
    @old_active_version = @new_active_version.post.active_version
    @new_active_version.update(status: :active)
    @new_active_version.tags.each &:touch
    @old_active_version.update(status: :archived) if @old_active_version
    @processing_version = @post.create_processing_version
    Pulitzer::CloneVersionJob.perform_later(@new_active_version)
    @post.reload
    @processing_version.reload
  end

  def make_version_abandoned
    @active_version = @transitional_version.post.active_version
    @transitional_version.update(status: :abandoned)
    if @active_version == @transitional_version
      @transitional_version.post.preview_version
    else
      @processing_version = @post.create_processing_version
      Pulitzer::CloneVersionJob.perform_later(@active_version)
      @processing_version
    end
  end

end
