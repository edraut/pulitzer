class Pulitzer::ContentElementsController < Pulitzer::ApplicationController
  before_action :set_content_element, only: [:show, :edit, :update]

  def show
    render partial: 'show', locals: { content_element: @content_element }
  end

  def edit
    render partial: 'form', locals: { content_element: @content_element }
  end

  def update
    Update.new(@content_element, content_element_params).call
    if @content_element.errors.empty?
      render partial: 'show', locals: { content_element: @content_element }
    else
      render partial: 'form', locals: { content_element: @content_element }, status: :conflict
    end
  end

  def update_all
    content_elements = Pulitzer::ContentElement.find params[:content_element]
    content_elements.each do |ce|
      new_sort_order = params[:content_element].index(ce.id.to_s)
      ce.update_attribute(:sort_order, new_sort_order)
    end
    head :ok and return
  end

  protected

  def content_element_params
    params[:content_element].nil? ? {} : params[:content_element].permit!
  end

  def set_content_element
    @content_element = Pulitzer::ContentElement.find(params[:id])
  end
end
