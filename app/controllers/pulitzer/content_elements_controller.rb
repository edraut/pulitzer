class Pulitzer::ContentElementsController < Pulitzer::ApplicationController
  before_filter :get_content_element, only: [:show, :edit, :update]

  def index
    @post = Pulitzer::Post.find(params[:post_id])
    @content_elements = @post.content_elements
  end

  def edit
    render partial: 'form', locals: { content_element: @content_element }
  end

  def update
    @content_element.update content_element_params
    render partial: 'show', locals: { content_element: @content_element }
  end

  protected

  def content_element_params
    params[:content_element].permit!
  end

  def get_content_element
    @content_element = Pulitzer::ContentElement.find(params[:id])
  end
end
