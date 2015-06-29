class Pulitzer::PostsController < Pulitzer::ApplicationController
  before_filter :get_post, only: [:show, :edit, :update]

  def index
    @posts = Pulitzer::Post.where(post_type_id: params[:post_type_id])
  end

  def new
    @post = Pulitzer::Post.new(post_type_id: params[:post_type_id])
    render partial: 'new', locals: { post: @post }
  end

  def create
    @post = Pulitzer::Post.create(post_params)
    render partial: 'show_wrapper', locals: { post: @post }
  end

  def show
    render partial: 'show', locals: { post: @post }
  end

  def edit
    render partial: 'form', locals: { post: @post }
  end

  def update
    @post.update_attributes(post_params)
    render partial: 'show', locals: { post: @post }
  end

  def destroy
    @post.destroy
    render nothing: true
  end

  protected

  def post_params
    params[:post].permit!
  end

  def get_post
    @post = Pulitzer::Post.find(params[:id])
  end

end
