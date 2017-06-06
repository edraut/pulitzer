class Pulitzer::PostTypesController < Pulitzer::ApplicationController
  before_action :get_post_type, except: [:index, :new, :create]

  def index
    if params[:post_type_kind]
      @post_type_kind = params[:post_type_kind]
    else
      @post_type_kind = 'template'
    end
    if request.xhr?
      @post_types = Pulitzer::PostType.send(@post_type_kind).order(name: :asc)
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
    head :ok
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
