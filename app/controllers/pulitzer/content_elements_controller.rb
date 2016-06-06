class Pulitzer::ContentElementsController < Pulitzer::ApplicationController
  before_filter :set_content_element, only: [:show, :edit, :update]

  def show
    render partial: 'show', locals: { content_element: @content_element }
  end

  def edit
    if 'context' == params[:edit_mode]
      render partial: 'form', locals: { content_element: @content_element }, layout: 'pulitzer/content_elements/context_form'
    else
      render partial: 'form', locals: { content_element: @content_element }
    end
  end

  def update
    @content_element.update content_element_params
    render partial: 'show', locals: { content_element: @content_element }
  end

  def update_all
    content_elements = Pulitzer::ContentElement.find params[:content_element]
    content_elements.each do |ce|
      new_sort_order = params[:content_element].index(ce.id.to_s)
      ce.update_attribute(:sort_order, new_sort_order)
    end
    render nothing: true
  end

  protected

  def content_element_params
    params[:content_element].permit!
  end

  def set_content_element
    @content_element = Pulitzer::ContentElement.find(params[:id])
  end
end
