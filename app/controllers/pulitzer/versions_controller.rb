class Pulitzer::VersionsController < Pulitzer::ApplicationController
  before_action :set_version

  def update
    Pulitzer::UpdateVersionStatus.new(@version,@status).call

    redirect_to post_content_elements_path(@post), notice: "Post #{@status}"
  end

private
  def set_version
    @version  = Pulitzer::Version.find params[:id]
    @post     = @version.post
    @status   = params[:status].to_sym
  end

end
