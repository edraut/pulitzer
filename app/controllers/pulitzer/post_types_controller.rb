class Pulitzer::PostTypesController < Pulitzer::ApplicationController
  before_action :get_post_type, except: [:import, :index, :new, :create]

  def index
    if params[:post_type_kind]
      @post_type_kind = params[:post_type_kind]
    else
      @post_type_kind = 'template'
    end
    if request.xhr?
      if Pulitzer.skip_metadata_auth? || self.instance_eval(&Pulitzer.metadata_closure)
        @post_types = Pulitzer::PostType.send(@post_type_kind).order(name: :asc)
      else
        @post_types = Pulitzer::PostType.send(@post_type_kind).joins(:post_type_versions).where(pulitzer_post_type_versions: {status: 'published'}).distinct.order(name: :asc)
      end
      render_ajax
    end
  end

  def new
    @post_type = Pulitzer::PostType.new(post_type_params)
    render partial: 'new', locals: {post_type: @post_type}
  end

  def create
    @post_type = Pulitzer::PostType.create(post_type_params)
    CreateTemplateVersion.new(@post_type).call
    render partial: 'show_wrapper', locals: {post_type: @post_type}
  end

  def show
    render partial: 'show', locals: {post_type: @post_type}
  end

  def export
    post_type_json = Export.new(@post_type).call
    send_data(post_type_json,
      disposition: 'attachment',
      filename: @post_type.name.parameterize + '.json')
  end

  def import
    @post_type = Import.new(params).call
    render partial: 'show_wrapper', locals: {post_type: @post_type}
  end

  def import_version
    @post_type_version = ImportVersion.new(@post_type, post_type_params).call
    if @post_type_version.errors.empty?
      render partial: '/pulitzer/post_type_versions/show_wrapper', locals: {post_type_version: @post_type_version}
    else
      render json: {flash_message: "Error importing: #{@post_type_version.errors.full_messages}"}, status: 409
    end
  end

  def edit
    render partial: 'form', locals: {post_type: @post_type}
  end

  def update
    @post_type.update_attributes(post_type_params)
    Pulitzer::UpdateSingletonPost.new(@post_type, post_params_name).call
    render partial: 'show', locals: {post_type: @post_type}
  end

  def destroy
    @post_type.destroy
    head :ok and return
  end

  protected

  def post_type_params
    params[:post_type].permit!
  end

  def post_params_name
    params[:post_type][:name]
  end

  def get_post_type
    @post_type = Pulitzer::PostType.find(params[:id])
  end

end
