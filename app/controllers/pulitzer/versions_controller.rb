class Pulitzer::VersionsController < Pulitzer::ApplicationController

  def update
    version = Pulitzer::Version.find params[:id]
    action = params[:commit].to_sym
    Pulitzer::CloneVersion.new(version, action).call
    redirect_to post_content_elements_path(version.post), notice: "Post published"
  end
end
