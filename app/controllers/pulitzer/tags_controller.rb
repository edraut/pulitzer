class Pulitzer::TagsController < Pulitzer::ApplicationController
  before_filter :get_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Pulitzer::Tag.where(hierarchical: true)
  end

  def new
    @tag = Pulitzer::Tag.new(tag_params)
    render partial: 'new', locals: {tag: @tag}
  end

  def edit
    render partial: 'form', locals: {tag: @tag}
  end

  def create
    @tag = Pulitzer::Tag.create(tag_params)
    render partial: 'show_wrapper', locals: {tag: @tag}
  end

  def update
    @tag.update_attributes(tag_params)
    render partial: 'show', locals: {tag: @tag}
  end

  def destroy
    @tag.destroy
    render nothing: true
  end

  protected

  def tag_params
    params[:tag].permit!
  end

  def get_tag
    @tag = Pulitzer::Tag.find(params[:id])
  end
end
