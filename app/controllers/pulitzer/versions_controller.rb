class Pulitzer::VersionsController < Pulitzer::ApplicationController
  before_action :set_version

  def update
    update_active_version
    new_version  = @post.create_preview_version
    @version.update(status: @status)
    if @active_version
      Pulitzer::CloneVersion.new(@active_version, new_version).call
    else
      Pulitzer::CreatePostContentElements.new(@post).call
    end
    redirect_to post_content_elements_path(@post), notice: "Post #{@status}"
  end

private
  def set_version
    @version  = Pulitzer::Version.find params[:id]
    @post     = @version.post
    @status   = params[:status].to_sym
  end

  def update_active_version
    if @status == :active
      @active_version = @version
      @post.active_version.update(status: :archived) if @post.active_version
    else
      @active_version = @post.active_version
    end
  end
end
