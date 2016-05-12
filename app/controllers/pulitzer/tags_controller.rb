class Pulitzer::TagsController < Pulitzer::ApplicationController
  def index
    @tags = Pulitzer::Tag.all
  end

  def new
    @tag = Pulitzer::Tag.new(tag_params)
    render partial: 'new', locals: {tag: @tag}
  end

  def create
    @tag = Pulitzer::Tag.create(tag_params)
    render partial: 'show_wrapper', locals: {tag: @tag}
  end

  protected

  def tag_params
    params[:tag].permit!
  end
end
