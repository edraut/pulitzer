class Pulitzer::StylesController < Pulitzer::ApplicationController
  before_action :get_style, only: [:show, :edit, :update, :destroy]

  def index
    @ptcet = Pulitzer::PostTypeContentElementType.find(params[:post_type_content_element_type_id])
    render partial: 'index', locals: { ptcet: @ptcet }
  end

  def new
    @style = Pulitzer::Style.new(style_params)
    render partial: 'new', locals: { ptcet: @ptcet, style: @style }
  end

  def create
    @style = Pulitzer::Style.create(style_params)
    if @style.errors.empty?
      render partial: 'show_wrapper', locals: { style: @style }
    else
      render partial: 'new', locals: { style: @style }
    end
  end

  def show
    render partial: 'show', locals: { style: @style }
  end

  def destroy
    @style.destroy
    head :ok
  end

  protected

  def get_style
    @style = Pulitzer::Style.find(params[:id])
  end

  def style_params
    params[:style].permit!
  end

end
