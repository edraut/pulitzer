class Pulitzer::UpdateVersionStatus
  def initialize(version, status)
    @transitional_version = version
    @status = status
    @status_change_method = 'make_version_' + @status.to_s
  end

  def call
    send @status_change_method
  end

  def make_version_active
    @new_active_version = @transitional_version
    @old_active_version = @new_active_version.post.active_version
    @new_active_version.update(status: :active)
    @old_active_version.update(status: :archived) if @old_active_version
    Pulitzer::CloneVersionJob.perform_later(@new_active_version)
    @new_active_version
  end

  def make_version_abandoned
    @active_version = @transitional_version.post.active_version
    @transitional_version.update(status: :abandoned)
    Pulitzer::CloneVersionJob.perform_later(@active_version)
  end

end