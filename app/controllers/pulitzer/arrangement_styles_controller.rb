class Pulitzer::ArrangementStylesController < Pulitzer::ApplicationController
  before_filter :get_arrangement_style, only: [:show, :edit, :update, :destroy]

  def new
    @arrangement_style = Pulitzer::ArrangementStyle.new(arrangement_style_params)
    @post_type = @arrangement_style.post_type
    render partial: 'new', locals: {arrangement_style: @arrangement_style}
  end

  def create
    @arrangement_style = Pulitzer::ArrangementStyle.create(arrangement_style_params)
    if @arrangement_style.errors.empty?
      render partial: 'show_wrapper', locals: {arrangement_style: @arrangement_style}
    else
      @post_type = @arrangement_style.post_type
      render partial: 'new', locals: {arrangement_style: @arrangement_style}
    end
  end

  def show
    render partial: 'show', locals: {arrangement_style: @arrangement_style}
  end

  def edit
    render partial: 'form', locals: {arrangement_style: @arrangement_style}
  end

  def update
    @arrangement_style.update_attributes(arrangement_style_params)
    if @arrangement_style.errors.empty?
      render partial: 'show', locals: {arrangement_style: @arrangement_style}
    else
      render partial: 'form', locals: {arrangement_style: @arrangement_style}, status: 409
    end
  end

  def destroy
    @arrangement_style.destroy
    head :ok
  end

  protected

  def get_arrangement_style
    @arrangement_style = Pulitzer::ArrangementStyle.find(params[:id])
  end

  def arrangement_style_params
    params[:arrangement_style].permit!
  end

end
