class Pulitzer::VersionsController < Pulitzer::ApplicationController
  before_action :set_version

  def edit
    if @version.preview?
      route                       = "#{Pulitzer.preview_namespace}_#{@post.post_type.name.parameterize('_')}_path"
      @preview_path               = main_app.public_send(route, @post.slug) if main_app.respond_to?(route)
    end
    render_ajax locals: {version: @version}
  end

  def update
    status_updater = Pulitzer::UpdateVersionStatus.new(@version, @status)
    if status_updater.errors.any?
      processing_version  = @version
      flash_message       = status_updater.errors.join("<br>").html_safe
      status = :conflict
    else
      processing_version  = status_updater.call
      if processing_version
        if processing_version.errors.empty?
          status = :ok
          flash_message     = "The new version of #{@post.title} has been activated."
        else
          status = :conflict
          flash_message = processing_version.errors.full_messages.join("<br>").html_safe
        end
      else
        flash[:notice] = "The post was successfully removed."
        render json: {class_triggers: {"hooch.ReloadPage" => posts_path(post_type_id: @version.post.post_type.id) }} and return
      end
    end
    render json: {html: render_to_string(partial: '/pulitzer/versions/edit', locals: {version: processing_version}),
                  flash_message: flash_message}, status: status
  end

private
  def set_version
    @version  = Pulitzer::Version.find params[:id]
    @status = params[:status]
    @post = @version.post
  end

end
