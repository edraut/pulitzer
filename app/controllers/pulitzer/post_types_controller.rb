class Pulitzer::PostTypesController < Pulitzer::ApplicationController
  before_filter :get_post_type, only: [:show, :edit, :update, :destroy]

  def index
    @post_types = Pulitzer::PostType.all
  end

  def new
    @post_type = Pulitzer::PostType.new
    render partial: 'new', locals: {post_type: @post_type}
  end

  def create
    @post_type = Pulitzer::PostType.create(post_type_params)
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
    render partial: 'show', locals: {post_type: @post_type}
  end

  def destroy
    @post_type.destroy
    render nothing: true
  end

  protected

  def post_type_params
    params[:post_type].permit!
  end

  def get_post_type
    @post_type = Pulitzer::PostType.find(params[:id])
  end

end
