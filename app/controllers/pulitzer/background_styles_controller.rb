class Pulitzer::BackgroundStylesController < Pulitzer::ApplicationController
  before_filter :get_background_style, only: [:show, :edit, :update, :destroy]

  def new
    @background_style = Pulitzer::BackgroundStyle.new(background_style_params)
    @post_type = @background_style.post_type
    render partial: 'new', locals: {background_style: @background_style}
  end

  def create
    @background_style = Pulitzer::BackgroundStyle.create(background_style_params)
    if @background_style.errors.empty?
      render partial: 'show_wrapper', locals: {background_style: @background_style}
    else
      @post_type = @background_style.post_type
      render partial: 'new', locals: {background_style: @background_style}
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
    head :ok
  end

  protected

  def get_background_style
    @background_style = Pulitzer::BackgroundStyle.find(params[:id])
  end

  def background_style_params
    params[:background_style].permit!
  end

end
