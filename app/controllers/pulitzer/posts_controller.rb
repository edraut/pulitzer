class Pulitzer::PostsController < Pulitzer::ApplicationController
  before_filter :get_post, only: [:show, :edit, :update, :processing_preview]

  def index
    @post_type = Pulitzer::PostType.find params[:post_type_id]
    @posts = Pulitzer::Post.where post_type: @post_type
  end

  def new
    @post = Pulitzer::Post.new(post_type_id: params[:post_type_id])
    render partial: 'new', locals: { post: @post }
  end

  def create
    @post = Pulitzer::Post.create(post_params)
    Pulitzer::CreatePostContentElements.new(@post).call if @post
    render partial: 'show_wrapper', locals: { post: @post }
  end

  def show
    render partial: 'show', locals: { post: @post }
  end

  def edit
    if request.xhr?
      render partial: 'form', locals: { post: @post }
    else
      if 'context' == params[:edit_mode]
        route                       = "pulitzer_preview_#{@post.post_type.name.parameterize('_')}_path"
        @preview_path               = main_app.public_send(route, @post.slug) if main_app.respond_to?(route)        
        redirect_to @preview_path if @preview_path
      end
    end
  end

  def update
    @post.update_attributes(post_params)
    render partial: 'show', locals: { post: @post }
  end

  def destroy
    @post.destroy
    render head :ok
  end

  protected

  def post_params
    params[:post].permit!
  end

  def get_post
    @post = Pulitzer::Post.find(params[:id])
  end

end
