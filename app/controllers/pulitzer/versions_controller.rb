class Pulitzer::VersionsController < Pulitzer::ApplicationController
  before_action :set_version

  def edit
    if @version.preview?
      route                       = "pulitzer_preview_#{@post.post_type.name.parameterize('_')}_path"
      @preview_path               = main_app.public_send(route, @post.slug) if main_app.respond_to?(route)
    end
    render_ajax locals: {version: @version}
  end

  def update
    if @status == "active" && @version.empty_required_content_elements?
      processing_version = @version
      flash_message      = "It's not possible to activate a version without filling required content elements"
    else
      processing_version = Pulitzer::UpdateVersionStatus.new(@version,@status).call
      flash_message      = "The new version of #{@post.title} has been activated."
    end
    render json: {html: render_to_string(partial: '/pulitzer/versions/edit', locals: {version: processing_version}),
                  flash_message: flash_message}
  end

private
  def set_version
    @version  = Pulitzer::Version.find params[:id]
    @status = params[:status]
    @post = @version.post
  end

end
