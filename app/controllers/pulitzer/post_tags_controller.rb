class Pulitzer::PostTagsController < Pulitzer::ApplicationController
  before_filter :get_post, only: [:new, :create]

  def new
    @tag_model = params[:tag_model]
    @post_tag = @post.post_tags.new
    render partial: 'new', locals: { post: @post, tag_model: @tag_model, post_tag: @post_tag }
  end

  def create
    @tag = @post.post_tags.create post_tag_params
    render partial: 'show', locals: { post: @post, tag_model: @tag.label_type }
  end

  protected

  def post_tag_params
    params[:post_tag].permit!
  end

  def get_post
    @post = Pulitzer::Post.find(params[:post_id])
  end

end
