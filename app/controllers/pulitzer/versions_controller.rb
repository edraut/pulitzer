class Pulitzer::VersionsController < Pulitzer::ApplicationController
  before_action :set_version

  def update
    action = params[:commit].to_sym
    active_version = @post.active_version
    new_version  = @post.create_version
    @version.update(status: action)
    if active_version || action == :active
      Pulitzer::CloneVersion.new(@post.active_version, new_version).call
    else
      Pulitzer::SetupPostElements.new(@post).call
    end
    redirect_to post_content_elements_path(@post), notice: "Post #{action}"
  end

private
  def set_version
    @version  = Pulitzer::Version.find params[:id]
    @post     = @version.post
  end
end
