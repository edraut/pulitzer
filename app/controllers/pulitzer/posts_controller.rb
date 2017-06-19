class Pulitzer::PostsController < Pulitzer::ApplicationController
  before_action :get_post, only: [:show, :edit, :edit_title, :edit_slug, :show_slug, :update,
    :update_slug, :processing_preview]
  before_action :get_version, only: [:edit_slug, :show_slug, :update_slug]

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
    @post = Pulitzer::Post.create(post_params)
    Pulitzer::CreatePostContentElements.new(@post).call if @post
    render partial: 'show_wrapper', locals: { post: @post }
  end

  def show
    render_ajax locals: { post: @post }
  end

  def edit
    render_ajax locals: { post: @post }
  end

  def edit_title
    render partial: 'form', locals: { post: @post }
  end

  def update
    @post.update_attributes(post_params)
    render partial: 'show', locals: { post: @post }
  end

  def destroy
    @post.destroy
    render head :ok
  end

  def edit_slug
    if request.xhr?
      render partial: 'form_slug', locals: { post: @post, version: @version }
    end
  end

  def show_slug
    render partial: 'show_slug', locals: { post: @post, version: @version }
  end

  def update_slug
    if @post.update_attributes(post_params)
      if @version.preview?
        route                       = "#{Pulitzer.preview_namespace}_#{@post.post_type.name.parameterize('_')}_path"
        @preview_path               = main_app.public_send(route, @post.slug) if main_app.respond_to?(route)
      end
      render partial: 'pulitzer/posts/edit', locals: { version: @version, post: @post }
    else
      render partial: 'form_slug', locals: { post: @post, version: @version }, status: :conflict
    end
  end

  protected

  def post_params
    params[:post].permit!
  end

  def get_version
    @version = Pulitzer::Version.find(params[:version_id])
  end

  def get_post
    @post = Pulitzer::Post.find(params[:id])
  end

end
