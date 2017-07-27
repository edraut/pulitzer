class Pulitzer::BackgroundStylesController < Pulitzer::ApplicationController
  before_action :get_background_style, only: [:show, :edit, :update, :destroy]

  def new
    @background_style = Pulitzer::BackgroundStyle.new(background_style_params)
    render partial: 'new', locals: {background_style: @background_style}
  end

  def create
    @background_style = Pulitzer::BackgroundStyle.create(background_style_params)
    if @background_style.errors.empty?
      render partial: 'show_wrapper', locals: {background_style: @background_style}
    else
      render partial: 'new', locals: {background_style: @background_style}, status: 409
    end
  end

  def show
    render partial: 'show', locals: {background_style: @background_style}
  end

  def edit
    render partial: 'form', locals: {background_style: @background_style}
  end

  def update
    @background_style.update_attributes(background_style_params)
    if @background_style.errors.empty?
      render partial: 'show', locals: {background_style: @background_style}
    else
      render partial: 'form', locals: {background_style: @background_style}, status: 409
    end
  end

  def destroy
    @background_style.destroy
    head :ok and return
  end

  protected

  def get_background_style
    @background_style = Pulitzer::BackgroundStyle.find(params[:id])
  end

  def background_style_params
    params[:background_style].permit!
  end

end
