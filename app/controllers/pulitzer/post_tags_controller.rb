class Pulitzer::PostTagsController < Pulitzer::ApplicationController
  before_action :get_post_tag, only: [:destroy]

  def new
    @tag_model = params[:tag_model]
    @version = Pulitzer::Version.find params[:version_id]
    @post_tag = @version.post_tags.new label_type: @tag_model
    render partial: 'new', locals: { tag_model: @tag_model, post_tag: @post_tag }
  end

  def create
    @post_tag = Pulitzer::CreatePostTag.new(params).call
    render partial: 'show', locals: { version: @post_tag.version, tag_model: @post_tag.label_type }
  end

  def destroy
    @post_tag.destroy
    head :ok
  end

  protected

  def post_tag_params
    params[:post_tag].permit!
  end

  def get_post_tag
    @post_tag = Pulitzer::PostTag.find(params[:id])
  end

end
