class Pulitzer::PostTagsController < Pulitzer::ApplicationController
  before_filter :get_post, only: [:new, :create, :destroy]

  def new
    @tag_model = params[:tag_model]
    @post_tag = @post.preview_version.post_tags.new
    render partial: 'new', locals: { post: @post, tag_model: @tag_model, post_tag: @post_tag }
  end

  def create
    @post_tag = Pulitzer::CreatePostTag.new(@post, params).call
    render partial: 'show', locals: { post: @post, tag_model: @post_tag.label_type }
  end

  def destroy
    @post_tag = @post.preview_version.post_tags.find params[:id]
    @post_tag.destroy
    render nothing: true
  end

  protected

  def post_tag_params
    params[:post_tag].permit!
  end

  def get_post
    @post = Pulitzer::Post.find(params[:post_id])
  end

end
