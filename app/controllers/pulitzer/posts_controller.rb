class Pulitzer::PostsController < Pulitzer::ApplicationController
  before_action :get_post, except: [:index, :new, :create]

  def index
    @post_type_version = Pulitzer::PostTypeVersion.find params[:post_type_version_id]
    @posts = Pulitzer::Post.where(post_type_version_id: @post_type_version).order(id: :desc)
    render_ajax
  end

  def new
    @post = Pulitzer::Post.new(post_type_version_id: params[:post_type_version_id])
    render_ajax locals: { post: @post }
  end

  def create
    @post = Create.new(post_params).call
    if @post.errors.empty?
      Pulitzer::CreatePostContentElements.new(@post).call if @post
      render partial: 'show_wrapper', locals: { post: @post }
    else
      render partial: 'new', locals: { post: @post }, status: 409
    end
  end

  def show
    render_ajax locals: { post: @post }
  end

  def edit
    route = "#{Pulitzer.preview_namespace}_#{@post.post_type.name.parameterize(separator: '_')}_path"
    if main_app.respond_to?(route)
      if @post.plural?
        @preview_path = main_app.public_send(route, @post.slug, {version_number: @post.post_type_version.version_number})
      else
        @preview_path = main_app.public_send(route, {version_number: @post.post_type_version.version_number})
      end
    end
    render_ajax locals: { post: @post }
  end

  def edit_title
    render partial: 'form', locals: { post: @post }
  end

  def export
    post_json = Export.new(@post).call
    send_data(post_json,
      disposition: 'attachment',
      filename: @post.title.parameterize + '_post.json')
  end

  def update
    Update.new(@post,post_params).call
    if @post.errors.empty?
      render partial: 'show', locals: { post: @post }
    else
      render partial: 'form', locals: { post: @post }, status: 409
    end
  end

  def destroy
    @post.destroy
    render head :ok and return
  end

  def edit_slug
    if request.xhr?
      render partial: 'form_slug', locals: { post: @post }
    end
  end

  def show_slug
    render partial: 'show_slug', locals: { post: @post, version: @version }
  end

  def update_slug
    Update.new(@post,post_params).call
    if @post.errors.empty?
      route                       = "#{Pulitzer.preview_namespace}_#{@post.post_type.name.parameterize(separator: '_')}_path"
      if @post.plural?
        @preview_path = main_app.public_send(route, @post.slug, {version_number: @post.post_type_version.version_number})
      else
        @preview_path = main_app.public_send(route, {version_number: @post.post_type_version.version_number})
      end
      render partial: 'show_slug', locals: { post: @post }
    else
      render partial: 'form_slug', locals: { post: @post }, status: :conflict
    end
  end

  protected

  def post_params
    params[:post].permit!
  end

  def get_post
    @post = Pulitzer::Post.find(params[:id])
  end

end
