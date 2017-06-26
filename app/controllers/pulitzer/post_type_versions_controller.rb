class Pulitzer::PostTypeVersionsController < Pulitzer::ApplicationController
  before_action :get_post_type_version, except: [:index, :new, :create]

  def index
    @post_type = Pulitzer::PostType.find(params[:post_type_id])
    @post_type_versions = @post_type.post_type_versions
    render_ajax
  end

  def create
    @post_type_version = Create.new(post_type_version_params).call
    render partial: 'show_wrapper', locals: {post_type_version: @post_type_version}
  end

  def show
    render partial: 'show', locals: {post_type_version: @post_type_version}
  end

  def destroy
    @post_type_version.destroy
    render nothing: true
  end

  def template
    render_ajax locals: {post_type_version: @post_type_version}
  end

  def change_state
    Pulitzer::PostTypeVersionsController::ChangeState.new(@post_type_version,params[:state_change]).call
    if @post_type_version.errors.empty?
      render partial: 'show', locals: {post_type_version: @post_type_version}
    else
      render json: {
        flash_message: @post_type_version.errors.full_messages.join('<br>'),
        html: render_to_string(partial: 'show', locals: {post_type_version: @post_type_version}) },
        status: :conflict
    end
  end

  protected

  def post_type_version_params
    params[:post_type_version].permit!
  end

  def post_params_name
    params[:post_type_version][:name]
  end

  def get_post_type_version
    @post_type_version = Pulitzer::PostTypeVersion.find(params[:id])
  end

end
